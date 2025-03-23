Shader "Custom/Black_2sided" {
	Properties {
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Fog {
				Mode 0
			}
			GpuProgramID 31394
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord4 : TEXCOORD4;
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
                tmp0 = v.vertex.yyyy * cb0[1];
                tmp0 = cb0[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb0[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb0[3];
                o.texcoord1.xyz = cb0[3].xyz * v.vertex.www + tmp0.xyz;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                tmp0.x = dot(v.normal.xyz, cb0[4].xyz);
                tmp0.y = dot(v.normal.xyz, cb0[5].xyz);
                tmp0.z = dot(v.normal.xyz, cb0[6].xyz);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                o.texcoord.xyz = tmp0.www * tmp0.xyz;
                o.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 1.0);
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			Fog {
				Mode 0
			}
			GpuProgramID 110589
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 unity_WorldToLight;
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
                float4 tmp2;
                tmp0 = v.vertex.yyyy * cb1[1];
                tmp0 = cb1[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb1[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb1[3];
                tmp2 = tmp1.yyyy * cb2[18];
                tmp2 = cb2[17] * tmp1.xxxx + tmp2;
                tmp2 = cb2[19] * tmp1.zzzz + tmp2;
                o.position = cb2[20] * tmp1.wwww + tmp2;
                tmp1.x = dot(v.normal.xyz, cb1[4].xyz);
                tmp1.y = dot(v.normal.xyz, cb1[5].xyz);
                tmp1.z = dot(v.normal.xyz, cb1[6].xyz);
                tmp1.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp1.w);
                o.texcoord.xyz = tmp1.www * tmp1.xyz;
                o.texcoord1.xyz = cb1[3].xyz * v.vertex.www + tmp0.xyz;
                tmp0 = cb1[3] * v.vertex.wwww + tmp0;
                o.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord3.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                o.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 1.0);
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			Fog {
				Mode 0
			}
			GpuProgramID 153075
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
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
                tmp0 = v.vertex.yyyy * cb0[1];
                tmp0 = cb0[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb0[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb0[3];
                o.texcoord1.xyz = cb0[3].xyz * v.vertex.www + tmp0.xyz;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                tmp0.x = dot(v.normal.xyz, cb0[4].xyz);
                tmp0.y = dot(v.normal.xyz, cb0[5].xyz);
                tmp0.z = dot(v.normal.xyz, cb0[6].xyz);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                o.texcoord.xyz = tmp0.www * tmp0.xyz;
                o.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 1.0);
                o.sv_target1 = float4(0.0, 0.0, 0.0, 0.0);
                o.sv_target2.xyz = inp.texcoord.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                o.sv_target2.w = 1.0;
                o.sv_target3 = float4(1.0, 1.0, 1.0, 1.0);
                return o;
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}