Shader "p0/Reflective/Bumped Specular SMap Transparent Cutoff" {
	Properties {
        // --- Core Lighting Properties ---
		_Color ("Main Color", Color) = (1,1,1,1) // Albedo multiplier and overall transparency

        // Note the texture usage swap compared to the opaque reference!
		_SpecMap ("Albedo (RGB) Specular Intensity (A)", 2D) = "white" {} // Albedo in RGB, Spec Intensity in A
        _MainTex ("Glossiness (R) Transparency (A)", 2D) = "white" {} // Glossiness/Smoothness in R, Alpha mask in A

		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1) // Base specular reflectance color
		_Glossness ("Specular Multiplier", Range(0.01, 10)) = 1 // Scales _SpecMap.a contribution
		_Specularness ("Glossiness Multiplier", Range(0.01, 10)) = 0.078125 // Scales _MainTex.r contribution (Shininess)

		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5) // Reflection intensity and tint
		_Cube ("Reflection Cubemap", Cube) = "" {}

		_BumpMap ("Normalmap (AG format)", 2D) = "bump" {} // Assume AG format
        // No _NormalIntensity property in stub, assume 1.0

        _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5 // Alpha test threshold

		// --- Fresnel / View Angle Effects ---
        // Controls specular/reflection intensity based on view angle (NdotV)
		_SpecVals ("Specular Fresnel (Base, Scale)", Vector) = (1.1, 2, 0, 0) // (Base, Scale, 0, 0) -> (Base + Scale * 0.5 * (1-NdotV)^2) * 0.5
        // Controls diffuse albedo based on view angle (NdotV)
		_DefVals ("Diffuse Fresnel (Base, Scale)", Vector) = (0.5, 0.7, 0, 0) // (Base, Scale, 0, 0) -> Albedo * (Base + Scale * 0.5 * (1-NdotV)^2)

        // --- Other Properties ---
		_BumpTiling ("Normal UV Tiling", Float) = 1 // Controls UV tiling for the normal map
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0

		// --- Unused / Effect Specific Properties (Preserved) ---
		_DropsSpec ("Drops spec", Float) = 128
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScale", Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
        _NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOffset ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
        // _Temperature property from Ref2 is missing, but _Temperature2 is here? Keep stub property.
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0) // Likely for heat effects, not core lighting

        // Properties needed for thermal vision, heat etc. from Ref1 (if re-added)
		// [Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		// _HeatVisible ("_HeatVisible([0-1] for thermalVision only)", Float) = 1
		// [HDR] _HeatColor1 ("_HeatColor1", Color) = (1,0,0,1)
		// [HDR] _HeatColor2 ("_HeatColor2", Color) = (1,0.34,0,1)
		// _HeatCenter ("_HeatCenter", Vector) = (0,0,0,1)
		// _HeatSize ("_HeatSize", Vector) = (0.02,0.04,0.02,1)
		// _HeatTemp ("_HeatTemp", Float) = 0
        // [HideInInspector] _ThermalVisionOn ("Thermal Vision Active", Float) = 0
        // [HideInInspector] _HeatThermalFactor ("Heat Thermal Factor", Float) = 1
	}

	SubShader {
        // Set tags for alpha testing
		Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
        LOD 300 // Match Ref2 LOD

        //----------------------------------------------------------------------
        // Deferred Shading Pass (G-Buffer Generation)
        //----------------------------------------------------------------------
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }

            // No Stencil block needed based on the provided properties

             Offset [_Factor], [_Units] // Apply depth offset

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0 // Match Ref1/Ref2 target

            // Compile variants for LDR/HDR pipelines
			#pragma multi_compile ___ UNITY_HDR_ON

            // Include necessary files
			#include "UnityCG.cginc"
            // #include "UnityDeferredLibrary.cginc" // Not strictly needed for this implementation
			#include "UnityStandardConfig.cginc" // For UNITY_SPECCUBE_LOD_STEPS, DecodeHDR etc.

            // Input structure from application
            // struct appdata_full includes position, normal, tangent, color, multiple texcoords

            // Structure interpolated from vertex to fragment shader (Matches Ref1)
            struct v2f {
                float4 pos              : SV_POSITION;
                float2 uv_MainTex       : TEXCOORD0; // Used for _MainTex, _SpecMap, _BumpMap (with tiling)
                // Tangent-to-World matrix columns
                float3 worldTangent     : TEXCOORD1;
                float3 worldBitangent   : TEXCOORD2;
                float3 worldNormal      : TEXCOORD3;
                // View direction in tangent space (normalized)
                float3 tangentViewDir   : TEXCOORD4;
                // World position
                float3 worldPos         : TEXCOORD5;
                // Ambient SH lighting (pre-calculated in VS)
                float3 ambientSH        : TEXCOORD6;
            };

            // Access properties
            sampler2D _MainTex; // Gloss(R), Alpha(A)
            float4 _MainTex_ST;
            sampler2D _SpecMap; // Albedo(RGB), SpecIntensity(A)
            float4 _SpecMap_ST; // Use _MainTex_ST for simplicity if UVs are shared
            sampler2D _BumpMap;
            // No _BumpMap_ST defined, assume using _MainTex_ST with _BumpTiling multiplier

            TextureCube _Cube;
            SamplerState sampler_Cube;

            fixed4 _Color;
			fixed4 _SpecColor;
            fixed4 _ReflectColor;
            float _Glossness;       // Specular intensity multiplier
            float _Specularness;    // Glossiness multiplier
            float _Cutoff;
            float _BumpTiling;      // Normal map UV multiplier
            float4 _SpecVals;       // x = Base, y = Scale
            float4 _DefVals;        // x = Base, y = Scale


            // Vertex Shader (Identical to ReferenceShader.shader)
            v2f vert(appdata_full v) {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);

                // World Position
                float4 worldPos4 = mul(unity_ObjectToWorld, v.vertex);
                o.worldPos = worldPos4.xyz;

                // Clip Position
                o.pos = UnityObjectToClipPos(v.vertex);

                // UV Coordinates (Use _MainTex UVs for all maps)
                o.uv_MainTex = TRANSFORM_TEX(v.texcoord, _MainTex);

                // Calculate Tangent Space Basis (TBN) in World Space
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float4 worldTangent4 = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);
                float3 worldTangent = normalize(worldTangent4.xyz);
                float tangentSign = worldTangent4.w * unity_WorldTransformParams.w; // Handedness
                float3 worldBitangent = normalize(cross(worldNormal, worldTangent) * tangentSign);

                // Store TBN columns
                o.worldTangent = worldTangent;
                o.worldBitangent = worldBitangent;
                o.worldNormal = worldNormal;

                // World Space View Direction
                float3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos4.xyz);

                // View Direction in Tangent Space (normalized)
                o.tangentViewDir = normalize(float3(dot(worldViewDir, worldTangent), dot(worldViewDir, worldBitangent), dot(worldViewDir, worldNormal)));

                // Ambient SH Lighting
                o.ambientSH = ShadeSH9(float4(worldNormal, 1.0));

                return o;
            }

            // Fragment Shader
            // Outputs: G-Buffer (Albedo, Specular+Smoothness, Normal, Emission+Refl+GI)
            void frag(v2f i,
                        out half4 outAlbedo : SV_Target0,           // RT0: Diffuse color (RGB), Occlusion (A)
                        out half4 outSpecSmoothness : SV_Target1,   // RT1: Specular color (RGB), Smoothness (A)
                        out half4 outNormal : SV_Target2,           // RT2: World normal (RGB), unused (A)
                        out half4 outEmission : SV_Target3          // RT3: Emission (RGB) + Indirect Lighting + Reflections
            ) {
                // Sample Textures (using shared UVs)
                float4 mainTexSample = tex2D(_MainTex, i.uv_MainTex); // Gloss(R), Alpha(A)
                float4 specMapSample = tex2D(_SpecMap, i.uv_MainTex); // Albedo(RGB), SpecIntensity(A)

                // --- Alpha Cutout ---
                half alphaValue = mainTexSample.a;
                // Apply global color alpha, then test (matches Ref2 logic)
                clip(alphaValue * _Color.a - _Cutoff);

                // Extract texture data
                float3 albedo = specMapSample.rgb * _Color.rgb;
                float specularIntensityMap = specMapSample.a;
                float glossMapValue = mainTexSample.r; // Glossiness/Smoothness from _MainTex.r

                // Normal Mapping
                float2 normalUV = i.uv_MainTex * _BumpTiling; // Apply tiling multiplier
                float4 packedNormal = tex2D(_BumpMap, normalUV);
                // Unpack AG format normal
                float3 tangentNormal;
                tangentNormal.xy = packedNormal.ag * 2 - 1; // Assume AG format based on Ref1 comment
                // No _NormalIntensity property, assume 1.0
                tangentNormal.z = sqrt(1.0 - saturate(dot(tangentNormal.xy, tangentNormal.xy)));

                // Reconstruct world TBN from interpolated vectors (normalize!)
                float3 worldTangent = normalize(i.worldTangent);
                float3 worldBitangent = normalize(i.worldBitangent);
                float3 worldGeomNormal = normalize(i.worldNormal);
                float3x3 tangentToWorld = float3x3(worldTangent, worldBitangent, worldGeomNormal);

                // Calculate Shading Normal in World Space
                float3 worldShadingNormal = normalize(mul(tangentNormal, tangentToWorld));

                // View Direction (World Space)
                float3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);

                // --- Calculations ---

                // Glossiness / Smoothness (for RT1.a)
                // Apply multiplier (_Specularness) to map value (_MainTex.r)
                half smoothness = saturate(glossMapValue * _Specularness);

                // NdotV (using tangent space data passed from VS)
                float NdotV = saturate(dot(normalize(i.tangentViewDir), tangentNormal)); // Dot view_tangent with normal_tangent

                // Custom Fresnel / View-dependent factors
                float fresnelTerm = pow(1.0 - NdotV, 2);
                float fresnelFactor = 0.5 * fresnelTerm; // The 0.5 applied in the original code

                // Specular/Reflection Factor (from _SpecVals)
                // specFactor = (Base + Scale * fresnelFactor) * 0.5
                half specFactor = saturate((_SpecVals.x + _SpecVals.y * fresnelFactor) * 0.5);

                // Diffuse Factor (from _DefVals) - Modifies albedo based on view angle
                // diffFactor = (Base + Scale * fresnelFactor)
                half diffFactor = saturate(_DefVals.x + _DefVals.y * fresnelFactor);

                // --- Modify Base Values ---

                // Modify Albedo
                albedo *= diffFactor;

                // Calculate Specular Intensity
                // Combines map value (_SpecMap.a), multiplier (_Glossness), and view-dependent factor (specFactor)
                half specularIntensity = specularIntensityMap * _Glossness * specFactor;

                // --- G-Buffer Outputs ---

                // RT0: Albedo
                outAlbedo = half4(albedo, 1.0); // Use 1.0 for occlusion/alpha

                // RT1: Specular Color & Smoothness
                outSpecSmoothness.rgb = _SpecColor.rgb * specularIntensity;
                outSpecSmoothness.a = smoothness;

                // RT2: World Normal (Encoded)
                outNormal = half4(worldShadingNormal * 0.5 + 0.5, 1.0); // Standard encoding

                // RT3: Emission / Indirect Lighting / Reflections

                // Reflection calculation
                float3 reflectVec = reflect(-worldViewDir, worldShadingNormal);
                half roughness = 1.0 - smoothness;
                half mipLevel = roughness * UNITY_SPECCUBE_LOD_STEPS;
                half4 encodedRefl = UNITY_SAMPLE_TEXCUBE_LOD(_Cube, reflectVec, mipLevel);
                half3 reflection = DecodeHDR(encodedRefl, encodedRefl.a); // Decode HDR cubemap
                // Modulate reflection
                reflection *= _ReflectColor.rgb * _ReflectColor.a; // Apply color & intensity
                reflection *= specularIntensityMap; // Modulate by specular map intensity (_SpecMap.a)
                reflection *= specFactor; // Modulate by the same view-dependent factor as specular

                // Indirect Diffuse Light (Ambient)
                // Use precomputed SH from VS, modulated by final albedo
                // Note: Ref1 used ShadeSH9(worldShadingNormal), Ref2 didn't have indirect diffuse. Using SH from VS is standard.
                // half3 ambientLight = ShadeSH9(half4(worldShadingNormal, 1.0)); // Alternative: calculate here
                half3 ambientLight = i.ambientSH; // Use value from VS
                half3 indirectDiffuse = ambientLight * albedo;

                // Combine Ambient Diffuse and Reflection for RT3
                half3 finalEmission = indirectDiffuse + reflection;

                // --- Thermal/Heat logic could be added here using _Temperature2 etc. ---

                // HDR / LDR Output Handling for RT3 (Matches Ref1)
                #ifdef UNITY_HDR_ON
                    outEmission = half4(finalEmission, 1.0);
                #else
                    // Apply the unusual exp(-color) encoding for LDR RT3 from Ref1
                    outEmission = half4(exp(-finalEmission), 1.0);
                #endif
			}
			ENDCG
		}

        //----------------------------------------------------------------------
        // Shadow Caster Pass
        //----------------------------------------------------------------------
        Pass {
            Name "ShadowCaster"
            Tags { "LIGHTMODE" = "SHADOWCASTER" }

            ZWrite On ZTest LEqual Cull Front // Standard shadow caster states
            Offset [_Factor], [_Units] // Apply offset here too

            CGPROGRAM
            #pragma vertex vertShadow
            #pragma fragment fragShadow
            #pragma target 3.0
            #pragma multi_compile_shadowcaster // Standard shadow caster directives

            #include "UnityCG.cginc"

            struct v2f_shadow {
                V2F_SHADOW_CASTER; // Includes position
                float2 uv : TEXCOORD0; // Need UVs for alpha test
            };

            // Declare properties needed for shadow pass fragment shader
            sampler2D _MainTex; // Need alpha channel from here
            float4 _MainTex_ST;
            fixed4 _Color; // Need alpha multiplier
            fixed _Cutoff;

            v2f_shadow vertShadow(appdata_base v) {
                v2f_shadow o;
                UNITY_INITIALIZE_OUTPUT(v2f_shadow, o);
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o) // Handles position + normal bias
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex); // Pass UVs
                return o;
            }

            fixed4 fragShadow(v2f_shadow i) : SV_Target {
                // Alpha testing
                fixed alpha = tex2D(_MainTex, i.uv).a;
                clip(alpha * _Color.a - _Cutoff); // Apply color alpha then clip

                SHADOW_CASTER_FRAGMENT(i) // Outputs depth
            }
            ENDCG
        }
	}
    // Fallback appropriate for cutout specular
	Fallback "Transparent/Cutout/Bumped Specular"
	CustomEditor "FresnelMaterialEditor" // Keep stub custom editor
}