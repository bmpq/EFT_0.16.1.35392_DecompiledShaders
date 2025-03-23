// a temporary dummy shader, with real Properties tho

Shader "Nature/SpeedTreeEFT" {
    Properties {
        _Color ("Main Color", Vector) = (1,1,1,1)
        _HueVariation ("Hue Variation", Vector) = (1,0.5,0,0.1)
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
        _DetailTex ("Detail", 2D) = "black" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.333
        [MaterialEnum(Off,0,Front,1,Back,2)] _Cull ("Cull", Float) = 2
        [MaterialEnum(None,0,Fastest,1,Fast,2,Better,3,Best,4,Palm,5)] _WindQuality ("Wind Quality", Range(0, 5)) = 0
        _Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
    }

    SubShader {
        Tags { "RenderType"="TreeTransparentCutout" "Queue"="AlphaTest"  "IgnoreProjector"="True" "DisableBatching"="True" "RenderPipeline"="UniversalRenderPipeline" }
        LOD 200

         Pass {
            Name "DEFERRED"
            Tags { "LightMode" = "Deferred" }

            Cull [_Cull]

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE // Add for LOD crossfading if you're using LOD groups.

            #include "UnityCG.cginc"

            struct appdata_full_eft
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 color : COLOR;  // Use vertex colors for wind and hue variation
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 uvDetail : TEXCOORD1;
                float3 normal : TEXCOORD2;
                float3 worldPos : TEXCOORD3;
                float4 color : COLOR; // Pass vertex color to fragment
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };



            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _DetailTex;
            float4 _DetailTex_ST;
            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            float4 _Color;
            float4 _HueVariation;
            float _Cutoff;
            float4 _Temperature2;


            v2f vert(appdata_full_eft v) {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o); // Pass instance ID to fragment
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // Simplified wind approximation (replace with actual SpeedTree wind shader if available)
                // This is a PLACEHOLDER; actual SpeedTree wind is much more complex.
                float4 wind = v.color; // Use vertex color.x for basic wind influence.
                float windStrength = 0.1; // Adjust as needed.
                v.vertex.xyz += v.normal * wind.x * windStrength * _SinTime.x;

                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                // Use UnityObjectToClipPos for correct clip-space position
                o.position = UnityObjectToClipPos(v.vertex); 
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uvDetail = TRANSFORM_TEX(v.texcoord1, _DetailTex);  // Assuming texcoord1 is for detail map

                //Normal
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                o.normal = worldNormal;

                o.color = v.color;  // Pass vertex color

                return o;
            }

            struct fout
            {
                float4 gbuffer0 : SV_Target0;  // Diffuse + Occlusion
                float4 gbuffer1 : SV_Target1;  // Specular + Smoothness
                float4 gbuffer2 : SV_Target2;  // Normal
                float4 gbuffer3 : SV_Target3; // Emission + Ambient
            };

            fout frag(v2f i) : SV_Target
            {

                UNITY_SETUP_INSTANCE_ID(i); // Set up instance ID

                fout o;

                float4 albedo = tex2D(_MainTex, i.uv) * _Color;
                // Apply Hue Variation (Simplified)
                float3 hue = i.color.rgb * _HueVariation.rgb; // Corrected: Use .rgb for color components
                albedo.rgb += hue;

                // Detail texturing
                float4 detail = tex2D(_DetailTex, i.uvDetail);
                albedo.rgb *= detail.rgb * 2.0;  // Multiply detail texture

                clip(albedo.a - _Cutoff);


                // Normal mapping
                float3 normal = UnpackNormal(tex2D(_BumpMap, i.uv));
                normal = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, normal)); // Transform normal to view space


                // Diffuse color, apply Temperature effect as emissive
                float3 finalColor = albedo.rgb;

				//apply temp
                finalColor.rgb *= _Temperature2.zzz;  // Corrected: Use .rgb for color components
                finalColor.rgb = max(finalColor.rgb, _Temperature2.xxx); // Corrected: Use .rgb for color components
                finalColor.rgb = min(finalColor.rgb, _Temperature2.yyy); // Corrected: Use .rgb for color components
                finalColor.rgb = finalColor.rgb + _Temperature2.www; // Corrected: Use .rgb


                // Simple lighting model for Deferred (you might integrate with Unity's PBR if needed)
                o.gbuffer0 = float4(finalColor, 1.0); // Albedo and alpha
                o.gbuffer1 = float4(0.0, 0.0, 0.0, 1.0); // Replace with specular and smoothness if you add them
                o.gbuffer2 = float4(normal, 1.0f);   // View-space normal
                o.gbuffer3 = float4(0.0, 0.0, 0.0, 1.0); //Emission (black, for now, add ambient if needed).

                return o;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}