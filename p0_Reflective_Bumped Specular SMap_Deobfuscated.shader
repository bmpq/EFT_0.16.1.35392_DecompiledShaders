// Deobfuscated with the help of 'gemini-2.5-pro-exp-03-25' so be warned
Shader "p0/Reflective/Bumped Specular SMap (Deobfuscated)" {
    Properties {
        [MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("Stencil Type", Float) = 0
        _Color ("Main Color", Color) = (1,1,1,1) // Albedo multiplier

        _MainTex ("Base (RGB) Specular Intensity (A)", 2D) = "white" {} // Alpha channel is indeed the specular map

        [Toggle(TINTMASK)] _HasTint ("Enable Tint Mask", Float) = 0
        _BaseTintColor ("Tint Color", Color) = (1,1,1,1)
        _TintMask ("Tint Mask (R)", 2D) = "black" {} // Assumes R channel for mask

        _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1) // Base specular reflectance color
        _SpecMap ("Glossiness Map (R)", 2D) = "white" {} // R channel controls smoothness/glossiness (confusing naming preserved for material deserialization)
        _Glossness ("Specular Intensity Multiplier", Range(0.01, 10)) = 1 // Scales _MainTex.a contribution (confusing naming preserved for material deserialization)
        _Specularness ("Glossiness Multiplier", Range(0.01, 10)) = 0.078125 // Scales _SpecMap.r contribution (Shininess) (confusing naming preserved for material deserialization)

        _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5) // Reflection intensity and tint
        _Cube ("Reflection Cubemap", Cube) = "" {}

        _BumpMap ("Normal Map (AG format)", 2D) = "bump" {} // Assumes AG format (common for DXT5nm)
        _NormalIntensity ("Normal Intensity", Float) = 1
        _NormalUVMultiplier ("Normal UV Tiling", Float) = 1 // Controls UV tiling for the normal map

        // Controls specular/reflection intensity based on view angle (NdotV)
        // FinalSpec = (_SpecFresnelBase + _SpecFresnelScale * 0.5 * (1-NdotV)^2) * 0.5
        _SpecVals ("Specular Fresnel (Base, Scale)", Vector) = (1.1, 2, 0, 0)
        // Controls diffuse albedo based on view angle (NdotV) - Unusual!
        // FinalAlbedo = Albedo * (_DiffFresnelBase + _DiffFresnelScale * 0.5 * (1-NdotV)^2)
        _DefVals ("Diffuse Fresnel (Base, Scale)", Vector) = (0.5, 0.7, 0, 0)

        _BumpTiling ("Bump Tiling (Legacy?)", Float) = 1 // Seems unused, _NormalUVMultiplier used instead

        _Factor ("Z Offset Angle", Float) = 0 // Offset = Factor * sin(angle) + Units
        _Units ("Z Offset Forward", Float) = 0

        // --- Properties below are likely irrelevant to core lighting, stripped down from this file ---
        [HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
        _DropsSpec ("Drops spec", Float) = 128
		_Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScale", Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
		_NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOffset ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		_HeatVisible ("_HeatVisible([0-1] for thermalVision only)", Float) = 1
		[HDR] _HeatColor1 ("_HeatColor1", Color) = (1,0,0,1)
		[HDR] _HeatColor2 ("_HeatColor2", Color) = (1,0.34,0,1)
		_HeatCenter ("_HeatCenter", Vector) = (0,0,0,1)
		_HeatSize ("_HeatSize", Vector) = (0.02,0.04,0.02,1)
		_HeatTemp ("_HeatTemp", Float) = 0
        [HideInInspector] _ThermalVisionOn ("Thermal Vision Active", Float) = 0
        [HideInInspector] _HeatThermalFactor ("Heat Thermal Factor", Float) = 1
    }

    SubShader {
        Tags { "RenderType" = "Opaque" }

        //----------------------------------------------------------------------
        // Deferred Shading Pass (G-Buffer Generation)
        //----------------------------------------------------------------------
        Pass {
            Name "DEFERRED"
            Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }

            // Stencil setup based on _StencilType (e.g., Static=0, Characters=1, Hands=2)
            Stencil {
                Ref [_StencilType] // Use the enum value directly
                ReadMask 3 // Allow reading lower 2 bits
                WriteMask 3 // Allow writing lower 2 bits (for type)
                Comp Always
                Pass Replace // Write Ref value if depth test passes
                Fail Keep
                ZFail Keep
            }

             Offset [_Factor], [_Units] // Apply depth offset

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0 // Assumed based on complexity and texCUBElod

            // Compile variants for LDR/HDR pipelines
            #pragma multi_compile ___ UNITY_HDR_ON

            // Compile variant for Tinting (although logic isn't in this pass)
            // #pragma multi_compile ___ TINTMASK

            #include "UnityCG.cginc"
            #include "UnityDeferredLibrary.cginc" // For potential helpers, though not explicitly used by decompiled code
            #include "UnityStandardConfig.cginc"

            // Input structure from application
            // struct appdata_full includes position, normal, tangent, color, multiple texcoords

            // Structureinterpolated from vertex to fragment shader
            struct v2f {
                float4 pos              : SV_POSITION;
                float2 uv_MainTex       : TEXCOORD0;
                // Tangent-to-World matrix (transposed? No, looks like columns)
                float3 worldTangent     : TEXCOORD1; // Stores T column (Tx, Ty, Tz)
                float3 worldBitangent   : TEXCOORD2; // Stores B column (Bx, By, Bz)
                float3 worldNormal      : TEXCOORD3; // Stores N column (Nx, Ny, Nz)
                // View direction in tangent space
                float3 tangentViewDir   : TEXCOORD4; // Stores (dot(V,T), dot(V,B), dot(V,N))
                // World position (passed for lighting/reflection calculations)
                float3 worldPos         : TEXCOORD5;
                // Ambient SH lighting (pre-calculated in VS)
                float3 ambientSH        : TEXCOORD6;

                // UNITY_FOG_COORDS(7) // If fog was needed
            };

            // Access properties
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _SpecMap;

            TextureCube _Cube;          // HLSL declaration for the cubemap texture
            SamplerState sampler_Cube;  // HLSL declaration for its sampler state

            sampler2D _BumpMap;
            // sampler2D _TintMask; // If tinting was used

            fixed4 _Color;
            fixed4 _BaseTintColor;
            fixed4 _SpecColor;
            fixed4 _ReflectColor;
            float _Glossness; // Specular intensity (confusing naming preserved for material deserialization)
            float _Specularness; // Glossiness intensity (confusing naming preserved for material deserialization)
            float _NormalIntensity;
            float _NormalUVMultiplier;
            float4 _SpecVals; // x = Base, y = Scale
            float4 _DefVals;  // x = Base, y = Scale

            // Vertex Shader
            v2f vert(appdata_full v) {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);

                // World Position
                float4 worldPos4 = mul(unity_ObjectToWorld, v.vertex);
                o.worldPos = worldPos4.xyz;

                // Clip Position
                o.pos = UnityObjectToClipPos(v.vertex);

                // UV Coordinates
                o.uv_MainTex = TRANSFORM_TEX(v.texcoord, _MainTex);

                // Calculate Tangent Space Basis (TBN) in World Space
                // Normalize is important for interpolated vectors
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                float4 worldTangent4 = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);
                float3 worldTangent = normalize(worldTangent4.xyz);
                float tangentSign = worldTangent4.w * unity_WorldTransformParams.w; // Handedness
                float3 worldBitangent = normalize(cross(worldNormal, worldTangent) * tangentSign);

                // Store TBN columns for fragment shader (or rows if preferred)
                o.worldTangent = worldTangent;
                o.worldBitangent = worldBitangent;
                o.worldNormal = worldNormal;

                // World Space View Direction
                float3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos4.xyz);

                // View Direction in Tangent Space (pass to fragment for NdotV calc there)
                // Can be reconstructed in frag from world ViewDir and world TBN if needed,
                // but pre-calculating dot products might be what the original did.
                 o.tangentViewDir.x = dot(worldViewDir, worldTangent);
                 o.tangentViewDir.y = dot(worldViewDir, worldBitangent);
                 o.tangentViewDir.z = dot(worldViewDir, worldNormal); // This is world NdotV (geom)
                 // Or, simply pass worldViewDir and calculate in frag? Let's pass TBN and worldViewDir separately
                 // For closer match to decompiled structure, pass dot products:
                 // o.tangentViewDir = float3(dot(worldViewDir, worldTangent), dot(worldViewDir, worldBitangent), dot(worldViewDir, worldNormal));
                 // It seems the original passed the *normalized* tangent view dir, let's keep that:
                 o.tangentViewDir = normalize(float3(dot(worldViewDir, worldTangent), dot(worldViewDir, worldBitangent), dot(worldViewDir, worldNormal)));


                // Ambient SH Lighting (simplified view) - match original calculation structure
                o.ambientSH = ShadeSH9(float4(worldNormal, 1.0));

                // UNITY_TRANSFER_FOG(o, o.pos); // If fog was needed
                return o;
            }

            // Fragment Shader
            // Outputs: G-Buffer (Albedo, Specular+Smoothness, Normal, Emission+Refl+GI)
            void frag(v2f i,
                        out half4 outAlbedo : SV_Target0,           // RT0: Diffuse color (RGB), Occlusion (A) - We output 1.0 for A
                        out half4 outSpecSmoothness : SV_Target1,   // RT1: Specular color (RGB), Smoothness (A)
                        out half4 outNormal : SV_Target2,           // RT2: World normal (RGB), unused (A)
                        out half4 outEmission : SV_Target3          // RT3: Emission (RGB) + Indirect Lighting + Reflections
            ) {
                // Sample Textures
                float4 mainTexSample = tex2D(_MainTex, i.uv_MainTex);
                float3 albedo = mainTexSample.rgb * _Color.rgb;
                float specularIntensityMap = mainTexSample.a;

                float glossMapValue = tex2D(_SpecMap, i.uv_MainTex).r; // Use R channel

                // Tinting (Example - if TINTMASK was enabled and logic was here)
                // #ifdef TINTMASK
                // float mask = tex2D(_TintMask, i.uv_MainTex).r;
                // albedo = lerp(albedo, albedo * _BaseTintColor.rgb, mask);
                // #endif

                // Normal Mapping
                float2 normalUV = i.uv_MainTex * _NormalUVMultiplier; // Use specified multiplier for UVs
                float4 packedNormal = tex2D(_BumpMap, normalUV);
                // UnpackNormal requires texture marked as Normal Map in Unity import settings
                // Or manual unpacking if needed (assuming AG format):
                float3 tangentNormal;
                // tangentNormal.xy = packedNormal.wy * 2 - 1; // DXT5nm (Unity standard 'Normal Map' type) swizzle might be .ag
                tangentNormal.xy = packedNormal.ag * 2 - 1; // Common alternative for DXT5nm/BC5
                tangentNormal.xy *= _NormalIntensity;
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
                // Apply multiplier to map value
                half smoothness = saturate(glossMapValue * _Specularness);

                // NdotV (using tangent space data passed from VS, as original likely did)
                // Or calculate here: float NdotV = saturate(dot(worldShadingNormal, worldViewDir));
                // Using precalculated tangentViewDir:
                float NdotV = saturate(dot(normalize(i.tangentViewDir), tangentNormal)); // Dot view_tangent with normal_tangent

                // Custom Fresnel / View-dependent factors
                // Common factor based on (1-NdotV)^2, scaled
                float fresnelTerm = pow(1.0 - NdotV, 2);
                float fresnelFactor = 0.5 * fresnelTerm; // The 0.5 applied in the original code

                // Specular/Reflection Factor (from _SpecVals)
                // specFactor = (Base + Scale * fresnelFactor) * 0.5
                half specFactor = saturate((_SpecVals.x + _SpecVals.y * fresnelFactor) * 0.5);

                // Diffuse Factor (from _DefVals) - Modifies albedo based on view angle
                // diffFactor = (Base + Scale * fresnelFactor)
                half diffFactor = saturate(_DefVals.x + _DefVals.y * fresnelFactor);

                // --- Modify Base Values ---

                // Modify Albedo (Unusual step)
                albedo *= diffFactor;

                // Calculate Specular Intensity
                // Combines map value, multiplier property, and view-dependent factor
                half specularIntensity = specularIntensityMap * _Glossness * specFactor;

                // --- G-Buffer Outputs ---

                // RT0: Albedo
                outAlbedo = half4(albedo, 1.0); // Use 1.0 for occlusion/alpha unless needed

                // RT1: Specular Color & Smoothness
                outSpecSmoothness.rgb = _SpecColor.rgb * specularIntensity;
                outSpecSmoothness.a = smoothness;

                // RT2: World Normal (Encoded)
                outNormal = half4(worldShadingNormal * 0.5 + 0.5, 1.0); // Standard encoding

                // RT3: Emission / Indirect Lighting / Reflections

                // Reflection calculation
                float3 reflectVec = reflect(-worldViewDir, worldShadingNormal);
                // Use glossiness to select mip level for blurry reflections
                // Unity automatically does this if cubemap has mips and sampler is texCUBElod
                // Roughness approx: roughness = 1.0 - smoothness; mip = roughness * UNITY_SPECCUBE_LOD_STEPS;
                half roughness = 1.0 - smoothness;
                half mipLevel = roughness * UNITY_SPECCUBE_LOD_STEPS;
                half4 encodedRefl = UNITY_SAMPLE_TEXCUBE_LOD(_Cube, reflectVec, mipLevel);
                // Decode reflection if necessary (e.g., RGBM), assume linear for now
                half3 reflection = DecodeHDR(encodedRefl, encodedRefl.a); // Use Unity's helper
                // Modulate reflection
                reflection *= _ReflectColor.rgb * _ReflectColor.a; // Apply color & intensity
                reflection *= specularIntensityMap; // Modulate by specular map intensity
                reflection *= specFactor; // Modulate by the same view-dependent factor as specular

                // Replaced the decompiled logic of 50 or so lines with the standard approach. Visually it looks the same (I think)
                half3 ambientLight = ShadeSH9(half4(worldShadingNormal, 1.0));
                
                half3 indirectDiffuse = ambientLight * albedo; // Modulate processed ambient by final albedo
                
                // Update Final Emission/Indirect calculation for RT3
                // Combine Ambient Diffuse and Reflection
                half3 finalEmission = indirectDiffuse + reflection;
                
                // --- Thermal vision logic would go here if re-added ---
                
                // HDR / LDR Output Handling for RT3
                #ifdef UNITY_HDR_ON
                    // proceed as usual
                    outEmission = half4(finalEmission, 1.0);
                #else
                    // Original unusual logic
                    // Without this, the output is pure white. Not sure why. Perhaps it has to do with custom post processing somewhere?
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

            ZWrite On ZTest LEqual Cull Front // Cull Front for standard shadow mapping
             Offset [_Factor], [_Units] // Apply offset here too

            CGPROGRAM
            #pragma vertex vertShadow
            #pragma fragment fragShadow
            #pragma target 3.0
            #pragma multi_compile_shadowcaster // Standard shadow caster directives

            #include "UnityCG.cginc"

            struct v2f_shadow {
                V2F_SHADOW_CASTER; // Includes position + potential extra coords
                // Add UVs if alpha testing is needed
                // float2 uv : TEXCOORD1;
            };

            // float4 _MainTex_ST; // If using UVs
            // sampler2D _MainTex; // If using alpha test

            v2f_shadow vertShadow(appdata_base v) {
                v2f_shadow o;
                UNITY_INITIALIZE_OUTPUT(v2f_shadow, o);
                // Calculate world position, apply offset, transform to light clip space
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o) // Handles position + normal bias
                // o.uv = TRANSFORM_TEX(v.texcoord, _MainTex); // If using UVs
                return o;
            }

            fixed4 fragShadow(v2f_shadow i) : SV_Target {
                // Alpha testing (if needed)
                // fixed alpha = tex2D(_MainTex, i.uv).a;
                // clip(alpha - _Cutoff); // Example _Cutoff property

                SHADOW_CASTER_FRAGMENT(i) // Outputs depth
            }
            ENDCG
        }
    }
    Fallback "Reflective/Bumped Diffuse"
    CustomEditor "FresnelMaterialEditor" // Probably internal BSG tool, we don't have it
}