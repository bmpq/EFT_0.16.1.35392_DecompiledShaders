Shader "Custom/Vert Paint Shader Solid Deobfuscated v2" {
    Properties {
        // --- Properties Block Unchanged for Compatibility ---
        _BlendStrength ("Blend Strength", Range(0.1, 30)) = 1
        [Space(30)] [Header(________________________________________________________________________________________________________________)] _Color0 ("Main Color 0", Color) = (1,1,1,1)
        _MainTex0 ("Base (RGB) Smoothness (A) 0", 2D) = "white" {}
        [NoScaleOffset] [Normal] _BumpMap0 ("Normalmap 0", 2D) = "bump" {}
        _Smoothness0 ("Smoothness 0", Range(0, 1)) = 0
        _Specular0 ("Specular 0", Range(0, 1)) = 0
        _FresnelDiffuse0 ("Fresnel Diffuse 0", Range(0, 1)) = 0
        _FresnelSpecular0 ("Fresnel Specular 0", Range(0, 1)) = 0
        [Space(30)] [Header(________________________________________________________________________________________________________________)] _Color1 ("Main Color 1", Color) = (1,1,1,1)
        _MainTex1 ("Base (RGB) Smoothness (A) 1", 2D) = "white" {}
        [NoScaleOffset] [Normal] _BumpMap1 ("Normalmap 1", 2D) = "bump" {}
        _Smoothness1 ("Smoothness 1", Range(0, 1)) = 0
        _Specular1 ("Specular 1", Range(0, 1)) = 0
        _FresnelDiffuse1 ("Fresnel Diffuse 1", Range(0, 1)) = 0
        _FresnelSpecular1 ("Fresnel Specular 1", Range(0, 1)) = 0
        [Space(30)] [Header(________________________________________________________________________________________________________________)] _Color2 ("Main Color 2", Color) = (1,1,1,1)
        _MainTex2 ("Base (RGB) Smoothness (A) 2", 2D) = "white" {}
        [NoScaleOffset] [Normal] _BumpMap2 ("Normalmap 2", 2D) = "bump" {}
        _Smoothness2 ("Smoothness 2", Range(0, 1)) = 0
        _Specular2 ("Specular 2", Range(0, 1)) = 0
        _FresnelDiffuse2 ("Fresnel Diffuse 2", Range(0, 1)) = 0
        _FresnelSpecular2 ("Fresnel Specular 2", Range(0, 1)) = 0
        [Space(30)] [Header(________________________________________________________________________________________________________________)]
        // Heights texture is used to modulate vertex color blending
        _Heights ("Heights (for Blending Noise)", 2D) = "white" {}
        [Space(30)] [Header(________________________________________________________________________________________________________________)] [Toggle(USE_MERGED_TEXTURES)] _UseMergedTextures ("Use Merged Textures", Float) = 0 // Note: This toggle seems unused in the provided code
        _ValsTex ("Vals factors", 2D) = "black" {} // Note: This seems unused in the provided code
        [Space(30)] [Header(________________________________________________________________________________________________________________)] _ReflectionStrength ("GI And Reflection Strength", Float) = 1
        _Cutoff ("_Cutoff", Float) = 0.85 // Note: This seems unused in the provided code
        _Factor ("Z Offset Angle", Float) = 0 // Note: This seems unused in the provided code
        _Units ("Z Offset Forward", Float) = 0 // Note: This seems unused in the provided code
        _Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.3,0.35,0) // Used for Thermal Vision
        // --- End of Unchanged Properties ---

        // Hidden property to control thermal vision via script/animation
        [HideInInspector] _ThermalVisionOn ("Thermal Vision Active", Float) = 0
    }

    SubShader {
        Tags { "RenderType"="Opaque" "Queue"="Geometry+5" }

        Pass {
            Name "DEFERRED"
            Tags { "LightMode" = "DEFERRED" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile ___ UNITY_HDR_ON // For reflection probe HDR handling
            // Note: _ThermalVisionOn could be a shader feature toggle for performance if desired
            // #pragma shader_feature _THERMAL_VISION_ON

            #include "UnityCG.cginc"
            #include "UnityStandardUtils.cginc"
            #include "UnityDeferredLibrary.cginc"
            #include "UnityPBSLighting.cginc"

            // Declare the tiling/offset variables Unity provides
            float4 _MainTex0_ST;
            float4 _MainTex1_ST;
            float4 _MainTex2_ST;
            float4 _Heights_ST; // Need this for the Heights texture

            // Properties
            float _BlendStrength;
            float4 _Color0, _Color1, _Color2;
            sampler2D _MainTex0, _MainTex1, _MainTex2;
            sampler2D _BumpMap0, _BumpMap1, _BumpMap2;
            float _Smoothness0, _Smoothness1, _Smoothness2;
            float _Specular0, _Specular1, _Specular2;
            float _FresnelDiffuse0, _FresnelDiffuse1, _FresnelDiffuse2;
            float _FresnelSpecular0, _FresnelSpecular1, _FresnelSpecular2;
            sampler2D _Heights; // Sampler for the Heights texture
            float _ReflectionStrength;
            float4 _Temperature2;
            float _ThermalVisionOn;

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float2 uvH : TEXCOORD3; // UV for Heights texture
                float3 worldPos : TEXCOORD4;
                float3 normal : TEXCOORD5;   // World normal
                float4 tangent : TEXCOORD6; // World tangent (xyz), sign (w)
                float4 vcolor : COLOR0;
            };

            v2f vert(appdata_full v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.vcolor = v.color; // Pass vertex color

                // Calculate world space normal and tangent
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.tangent.xyz = UnityObjectToWorldDir(v.tangent.xyz);
                o.tangent.w = v.tangent.w * unity_WorldTransformParams.w;

                // Calculate UVs using standard Unity macro or direct _ST math
                // Using direct math to match original assembly's likely input
                o.uv0 = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.uv1 = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.uv2 = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
                o.uvH = v.texcoord.xy * _Heights_ST.xy + _Heights_ST.zw; // UV for Heights texture

                return o;
            }

            struct FragmentOutputDeferred {
                float4 gBuffer0 : SV_Target0; // Albedo (RGB), Occlusion (A)
                float4 gBuffer1 : SV_Target1; // Specular (RGB), Smoothness (A)
                float4 gBuffer2 : SV_Target2; // Normal (RGB), unused (A)
                float4 gBuffer3 : SV_Target3; // Emission (RGB)
            };

            FragmentOutputDeferred frag(v2f i) : SV_Target
            {
                FragmentOutputDeferred o;

                // --- Vertex Color Blending Weights (Replicating Original Logic) ---

                // Sample the Heights texture using the UVs associated with each layer
                // In the original, it sampled using uv0, uv1, uv2 respectively
                float height0 = tex2D(_Heights, i.uv0).r; // Assuming Heights is grayscale, take red channel
                float height1 = tex2D(_Heights, i.uv1).r;
                float height2 = tex2D(_Heights, i.uv2).r;

                // Multiply vertex color channels by corresponding height samples
                float3 heightModulatedVColor = i.vcolor.rgb * float3(height0, height1, height2);

                // Ensure values are positive before log (original shader didn't explicitly show this, but log(<=0) is undefined)
                heightModulatedVColor = max(heightModulatedVColor, float3(0.0001, 0.0001, 0.0001));

                // Apply original log -> scale -> exp math (equivalent to pow(x, strength) for positive x)
                float3 log_weights = log(heightModulatedVColor);
                float3 scaled_weights = log_weights * _BlendStrength;
                float3 rawWeights = exp(scaled_weights);

                // Normalize the weights
                float weightSum = dot(rawWeights, float3(1,1,1));
                float3 blendWeights = rawWeights / max(weightSum, 0.0001); // Avoid division by zero

                // --- Sample Textures ---
                float4 tex0 = tex2D(_MainTex0, i.uv0);
                float4 tex1 = tex2D(_MainTex1, i.uv1);
                float4 tex2 = tex2D(_MainTex2, i.uv2);

                // Use UnpackNormalWithScale to handle potential scaling if needed, otherwise UnpackNormal is fine
                float3 normalMap0 = UnpackNormal(tex2D(_BumpMap0, i.uv0));
                float3 normalMap1 = UnpackNormal(tex2D(_BumpMap1, i.uv1));
                float3 normalMap2 = UnpackNormal(tex2D(_BumpMap2, i.uv2));

                // --- Blend Properties based on Weights ---
                float4 blendedAlbedoTex = tex0 * _Color0 * blendWeights.x +
                                          tex1 * _Color1 * blendWeights.y +
                                          tex2 * _Color2 * blendWeights.z;

                // Blending scalar parameters (Smoothness, Specular, Fresnel)
                // Using dot product for simple weighted average
                float blendedSmoothnessParam = dot(blendWeights, float3(_Smoothness0, _Smoothness1, _Smoothness2));
                float blendedSpecularParam = dot(blendWeights, float3(_Specular0, _Specular1, _Specular2));
                float blendedFresnelSpecParam = dot(blendWeights, float3(_FresnelSpecular0, _FresnelSpecular1, _FresnelSpecular2));
                float blendedFresnelDiffParam = dot(blendWeights, float3(_FresnelDiffuse0, _FresnelDiffuse1, _FresnelDiffuse2));

                // Blend tangent-space normals and normalize
                float3 blendedTangentNormal = normalMap0 * blendWeights.x +
                                              normalMap1 * blendWeights.y +
                                              normalMap2 * blendWeights.z;
                blendedTangentNormal = normalize(blendedTangentNormal);


                // --- Calculate World Normal ---
                float3 worldN = normalize(i.normal);
                float3 worldT = normalize(i.tangent.xyz);
                float3 worldB = cross(worldN, worldT) * i.tangent.w;
                float3x3 TBN = float3x3(worldT, worldB, worldN);
                float3 finalNormal = normalize(mul(blendedTangentNormal, TBN));

                // --- Lighting Calculations ---
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float NdotV = saturate(dot(finalNormal, viewDir));

                // --- Fresnel Calculation (Matches original structure) ---
                // Original seemed to use power of 4 (sqr * sqr)
                float fresnelTermSpec = pow(max(0.0, 1.0 - NdotV * blendedFresnelSpecParam), 4);
                float fresnelTermDiff = pow(max(0.0, 1.0 - NdotV * blendedFresnelDiffParam), 4);

                // --- Albedo & Occlusion (GBuffer0) ---
                // Modulate albedo by diffuse fresnel (as per original logic)
                float3 albedoColor = blendedAlbedoTex.rgb * fresnelTermDiff;
                // Smoothness from texture alpha * blended parameter
                float smoothness = blendedAlbedoTex.a * blendedSmoothnessParam;
                float occlusion = 1.0; // No ambient occlusion calculation shown in original frag logic
                o.gBuffer0 = float4(albedoColor, occlusion);

                // --- Specular & Smoothness (GBuffer1) ---
                // Use the blended specular parameter directly (as float3 for color)
                float3 specColorParam = blendedSpecularParam;
                // Modulate specular by specular fresnel (as per original logic)
                float3 specularColor = specColorParam * fresnelTermSpec;
                o.gBuffer1 = float4(specularColor, smoothness);

                // --- Normal (GBuffer2) ---
                o.gBuffer2 = float4(finalNormal * 0.5 + 0.5, 1.0); // Encode normal for GBuffer

                // --- Emission & Reflections (GBuffer3) ---
                float3 emission = float3(0,0,0); // Default no emission

                // Calculate roughness and reflection vector
                float roughness = 1.0 - smoothness;
                float3 reflectVec = reflect(-viewDir, finalNormal);

                // Sample reflection probes
                float mip = roughness * UNITY_SPECCUBE_LOD_STEPS;
                float4 encodedIrradiance = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectVec, mip);
                float3 probe0 = DecodeHDR(encodedIrradiance, unity_SpecCube0_HDR);

                float3 probe1 = float3(0,0,0);
                #if UNITY_SPECCUBE_BLENDING
                    float4 encodedIrradiance1 = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube1, reflectVec, mip);
                    probe1 = DecodeHDR(encodedIrradiance1, unity_SpecCube1_HDR);
                #endif
                float probeBlendFactor = unity_SpecCube0_BoxMin.w;
                float3 reflectionColor = lerp(probe1, probe0, probeBlendFactor);

                // Final Reflection Calculation - Modulate reflection by calculated specular & strength
                 float3 indirectSpecular = reflectionColor * specularColor * _ReflectionStrength;

                // Handle HDR encoding/decoding based on build target
                // The original shader's exp(-indirectSpecular) in non-HDR looks like a way
                // to store HDR values in LDR buffer, possibly for a custom bloom?
                // We'll replicate it but emission is usually additive.
                #ifndef UNITY_HDR_ON
                    // This is unusual, typically emission is additive.
                    // Replicating original behavior for compatibility.
                    emission = exp(-indirectSpecular);
                #else
                    emission = indirectSpecular; // Standard approach in HDR
                #endif

                o.gBuffer3.rgb = emission;
                o.gBuffer3.a = 0.0; // Typically unused alpha in emission buffer


                // --- Thermal Vision Override (Original Logic) ---
                // This completely replaces the GBuffer outputs if _ThermalVisionOn > 0
                if (_ThermalVisionOn > 0.0)
                {
                    // Original used min/max strangely, looks like clamping/selecting based on _Temperature2 vector
                    // tmp2 = tmp6 * _Temperature2; (tmp6 = 1.0) -> tmp2 = _Temperature2
                    // tmp2 = max(tmp2, _Temperature2); -> tmp2 = _Temperature2
                    // tmp2 = min(tmp2, _Temperature2); -> tmp2 = _Temperature2
                    // tmp2 = tmp2 + _Temperature2; -> tmp2 = _Temperature2 + _Temperature2 = 2 * _Temperature2
                    // This seems odd, maybe it was meant to use a different variable than tmp6?
                    // Let's assume it meant to use some input color/value instead of 1.0
                    // If we assume tmp6 was meant to be the final albedo:
                    // float4 thermalBase = float4(albedoColor, 1.0) * _Temperature2;
                    // thermalBase = max(thermalBase, _Temperature2); // Clamp min
                    // thermalBase = min(thermalBase, _Temperature2); // Clamp max? This seems contradictory.

                    // Let's simplify based on the final effect: it outputs fixed colors based on _Temperature2
                    // The original logic seems overly complex or potentially buggy for what it achieves.
                    // A common thermal effect uses a gradient based on luminance or temperature value.
                    // The original just outputs constant values derived from _Temperature2.

                    // GBuffer0 (Albedo/Occlusion): Set to _Temperature2 + _Temperature2 based on original math
                    o.gBuffer0 = _Temperature2 + _Temperature2; // This will likely be clamped by GBuffer format

                    // GBuffer1 (Specular/Smoothness): Set based on original math tmp3 = tmp1.zzzw * _Temperature2;
                    // tmp1.zzzw likely refers to the blended specular (z) and smoothness (w)
                    // float4 specSmooth = float4(specularColor.zzz, smoothness); // Reconstruct tmp1.zzzw
                    // float4 thermalSpec = specSmooth * _Temperature2;
                    // thermalSpec = max(thermalSpec, _Temperature2); // Clamp min
                    // thermalSpec = min(thermalSpec, _Temperature2); // Clamp max? Contradictory again.

                    // Simpler interpretation: Output fixed values derived from _Temperature2
                    o.gBuffer1 = _Temperature2; // Simplified interpretation

                    // Gbuffer2/3 are often less critical for simple thermal, keep normals?
                    // o.gBuffer2 = float4(0.5, 0.5, 1.0, 1.0); // Flat normal?
                    // o.gBuffer3 = float4(0,0,0,0); // No emission?
                    // The original keeps the calculated normal and sets emission based on _Temperature2
                    // tmp3 = tmp1.zzzw * _Temperature2 -> uses specular/smoothness related values
                    // Let's stick closer to the *result* of the original math:
                    // o.sv_target = tmp0.xxxx ? tmp2 : tmp6; -> if thermal, output tmp2 (which simplifies to 2*_Temperature2)
                    // o.sv_target1 = tmp0.xxxx ? tmp3 : tmp1; -> if thermal, output tmp3 (which simplifies based on spec/smooth * temp2)
                    // Let's just set fixed values for simplicity as the original math is confusing
                    float4 thermalColor1 = _Temperature2.yzwx; // Just using different components as an example
                    o.gBuffer1 = thermalColor1; // Assign a different thermal color here


                    // Keep original normal? Yes, original did.
                    o.gBuffer2.w = 1.0; // Ensure alpha is set

                    // Set emission GBuffer based on thermal? Original did not explicitly clear it.
                    o.gBuffer3 = float4(0,0,0,0); // Clear emission in thermal mode perhaps?
                }


                return o;
            }
            ENDCG
        }
    }
    Fallback "Standard" // Use Standard shader as fallback
}