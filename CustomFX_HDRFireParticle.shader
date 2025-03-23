Shader "CustomFX/HDRFireParticle" {
	Properties {
		_TintColor ("Smoke Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_HDRAmount ("HDR Mult", Range(1, 20)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "MBOIT_Pass"
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 40768
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 color : COLOR0;
				float2 texcoord : TEXCOORD0;
				uint3 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _TintColor;
			float _HDRAmount;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0.xyz = float3(0.0, 0.0, 0.0);
                //unsupported_nop;
                tmp1.xyz = v.vertex.xyz;
                //unsupported_nop;
                tmp1.xyz = tmp1.xyz;
                tmp2 = tmp1.xxxx * unity_ObjectToWorld._m00_m10_m20_m30;
                tmp3 = tmp1.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp2 = tmp2 + tmp3;
                tmp1 = tmp1.zzzz * unity_ObjectToWorld._m02_m12_m22_m32;
                tmp1 = tmp1 + tmp2;
                tmp2 = unity_ObjectToWorld._m03_m13_m23_m33 * float4(1.0, 1.0, 1.0, 1.0);
                tmp1 = tmp1 + tmp2;
                tmp2 = tmp1.xxxx * unity_MatrixVP._m00_m10_m20_m30;
                tmp3 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = tmp2 + tmp3;
                tmp3 = tmp1.zzzz * unity_MatrixVP._m02_m12_m22_m32;
                tmp2 = tmp2 + tmp3;
                tmp1 = tmp1.wwww * unity_MatrixVP._m03_m13_m23_m33;
                tmp1 = tmp1 + tmp2;
                tmp1 = tmp1;
                tmp1 = tmp1;
                tmp2 = v.color;
                tmp3.xy = v.texcoord.xy * _MainTex_ST.xy;
                tmp3.xy = tmp3.xy + _MainTex_ST.zw;
                o.position = tmp1;
                o.color = tmp2;
                o.texcoord6.xyz = tmp0.xyz;
                o.texcoord.xy = tmp3.xy;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                tmp0.x = tex2D(_MainTex, inp.texcoord.xy);
                tmp0 = tmp0.xxxx;
                tmp0 = tmp0;
                tmp1.xyz = inp.color.xyz;
                tmp0.xyz = tmp0.xyz * tmp1.xyz;
                tmp0.xyz = tmp0.xyz * _TintColor.xyz;
                tmp1.x = inp.color.w;
                tmp1.x = tmp1.x * _HDRAmount;
                tmp0.xyz = tmp0.xyz * tmp1.xxx;
                tmp1.xyz = inp.color.www;
                tmp0.xyz = tmp0.xyz * tmp1.xyz;
                tmp1.x = inp.color.w;
                tmp0.w = tmp0.w * tmp1.x;
                tmp0.w = tmp0.w * _TintColor.w;
                o.sv_target.xyz = tmp0.xyz;
                o.sv_target.w = tmp0.w;
                return o;
			}
			ENDCG
		}
	}
}