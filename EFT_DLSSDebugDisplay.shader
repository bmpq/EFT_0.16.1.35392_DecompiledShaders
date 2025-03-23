Shader "EFT/DLSSDebugDisplay" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_DepthTex ("Texture", 2D) = "white" {}
		_MotionVectorsTex ("Texture", 2D) = "white" {}
		_SrcColorTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 30505
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float2 texcoord : TEXCOORD0;
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
                o.texcoord.xy = v.texcoord.xy;
                o.position = v.vertex;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0.xy = inp.texcoord.xy + inp.texcoord.xy;
                tmp0 = tex2D(0, tmp0.xy);
                tmp1.xy = inp.texcoord.yx < float2(0.5, 0.5);
                tmp1.z = tmp1.x ? tmp1.y : 0.0;
                tmp2 = inp.texcoord.xyxy > float4(0.5, 0.5, 0.5, 0.5);
                tmp1.xy = tmp1.xy ? tmp2.xy : 0.0;
                tmp1.w = tmp2.w ? tmp2.z : 0.0;
                tmp1 = tmp1 ? 1.0 : 0.0;
                tmp2 = inp.texcoord.xyxy * float4(2.0, 2.0, 2.0, 2.0) + float4(-1.0, -0.0, -0.0, -1.0);
                tmp3 = tex2D(3, tmp2.xy);
                tmp2 = tex2D(1, tmp2.zw);
                tmp2.xyz = tmp2.xxx * float3(100.0, 100.0, 100.0);
                tmp3 = tmp1.xxxx * tmp3;
                tmp0 = tmp0 * tmp1.zzzz + tmp3;
                tmp2.w = 1.0;
                tmp0 = tmp2 * tmp1.yyyy + tmp0;
                tmp1.xy = inp.texcoord.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2 = tex2D(2, tmp1.xy);
                tmp2.xy = abs(tmp2.xy) * float2(1000000.0, 1000000.0);
                tmp2.zw = float2(0.0, 1.0);
                o.sv_target = tmp2 * tmp1.wwww + tmp0;
                return o;
			}
			ENDCG
		}
	}
}