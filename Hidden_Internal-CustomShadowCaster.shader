Shader "Hidden/Internal-CustomShadowCaster" {
	Properties {
	}
	SubShader {
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "SHADOWSUPPORT" = "true" }
			ColorMask 0
			ZClip Off
			Cull Front
			GpuProgramID 14021
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

            // --- Constant Buffer Declarations ---
            cbuffer cb0 : register(b0)
            {
                // float4x4 _Object2World; // cb0[0] - Often the object's transformation matrix
                // float4x4 _World2Object; // cb0[1]
                // ... other variables in cb0 ...
                float4 cb0[6]; // Placeholder.  We need the correct size!
            };

            cbuffer cb1 : register(b1)
            {
                float4 cb1[4];  // Model matrix (likely) - 4 rows of float4
            };

            cbuffer cb2 : register(b2)
            {
                float4 cb2[21]; // Projection matrix (likely) - at least 21 rows needed
            };

			struct v2f
			{
				float4 position : SV_POSITION0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * cb1[1];
                tmp0 = cb1[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb1[2] * v.vertex.zzzz + tmp0;
                tmp0 = tmp0 + cb1[3];
                tmp1 = tmp0.yyyy * cb2[18];
                tmp1 = cb2[17] * tmp0.xxxx + tmp1;
                tmp1 = cb2[19] * tmp0.zzzz + tmp1;
                tmp0 = cb2[20] * tmp0.wwww + tmp1;
                tmp1.x = cb0[5].x / tmp0.w;
                tmp1.x = min(tmp1.x, 0.0);
                tmp1.x = max(tmp1.x, -1.0);
                tmp0.z = tmp0.z + tmp1.x;
                tmp1.x = min(tmp0.w, tmp0.z);
                o.position.xyw = tmp0.xyw;
                tmp0.x = tmp1.x - tmp0.z;
                o.position.z = cb0[5].y * tmp0.x + tmp0.z;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
	}
}