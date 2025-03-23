Shader "Custom/Black_2sided" {
    Properties {
    }
    SubShader {
        Tags { "RenderType" = "Opaque" }
        Pass {
            Name "DEFERRED"
            Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
            Fog {
                Mode Off
            }
            GpuProgramID 153075
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // --- Constant Buffer Declarations ---
            // Use a custom name to avoid conflict with UnityPerDraw
            CBUFFER_START(MyCustomPerObjectData)
                float4 unity_ObjectToWorld_IT[3]; // Inverse transpose for normals
            CBUFFER_END
            // --- End Constant Buffer Declarations ---

            struct v2f
            {
                float4 position : SV_POSITION0;
                float3 texcoord : TEXCOORD0;  // World-space normal
                float3 texcoord1 : TEXCOORD1; // World-space position
                float4 texcoord2 : TEXCOORD2;
                float4 texcoord3 : TEXCOORD3;
            };

            struct fout
            {
                float4 sv_target : SV_Target0;
                float4 sv_target1 : SV_Target1;
                float4 sv_target2 : SV_Target2;
                float4 sv_target3 : SV_Target3;
            };

            v2f vert(appdata_full v)
            {
                v2f o;
                float4 worldPos;
                float3 worldNormal;

                // Transform vertex to world space
                worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.texcoord1.xyz = worldPos.xyz;

                // Calculate clip-space position
                o.position = mul(UNITY_MATRIX_VP, v.vertex);

                // Transform normal to world space (more efficient calculation)
                worldNormal.x = dot(v.normal.xyz, unity_ObjectToWorld_IT[0].xyz);
                worldNormal.y = dot(v.normal.xyz, unity_ObjectToWorld_IT[1].xyz);
                worldNormal.z = dot(v.normal.xyz, unity_ObjectToWorld_IT[2].xyz);
                o.texcoord.xyz = normalize(worldNormal); // Normalize *after* transformation


                o.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
            }

            fout frag(v2f inp)
            {
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 1.0);  // Black color
                o.sv_target1 = float4(0.0, 0.0, 0.0, 0.0);  // No specular
                o.sv_target2.xyz = inp.texcoord.xyz * 0.5 + 0.5; // Normal output (for debugging/visualization if needed)
                o.sv_target2.w = 1.0;
                o.sv_target3 = float4(1.0, 1.0, 1.0, 1.0);  // Full smoothness (doesn't matter since it's black)
                return o;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}