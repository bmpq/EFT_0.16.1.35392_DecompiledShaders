Shader "EFT/DistantShadowDownscaleDepth" {
	Properties {
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" }
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 30680
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
                o.position.xyw = v.vertex.xyw;
                o.position.z = 0.5;
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
                float4 tmp4;
                float4 tmp5;
                float4 tmp6;
                float4 tmp7;
                tmp1.xy = float2(int2(tmp0.xy) << 2);
                tmp0.xy = uint2(tmp0.xy) & uint2(float2(0.0, 0.0));
                tmp0.x = tmp0.y + tmp0.x;
                tmp0.x = tmp0.x == 1;
                tmp2 = tmp1.xyxy + int4(2, 0, 1, 1);
                tmp3.y = tmp2.w;
                tmp4.y = tmp3.y;
                tmp1.z = 0.0;
                tmp4.xzw = tmp1.xzz;
                tmp5 = Load(rsc0, tmp4.xyz);
                tmp1.w = tmp2.z;
                tmp3.xz = tmp1.wz;
                tmp6 = Load(rsc0, tmp1.wyz);
                tmp7 = Load(rsc0, tmp1.xyz);
                tmp0.y = max(tmp6.x, tmp7.x);
                tmp6 = Load(rsc0, tmp3.xyz);
                tmp0.z = max(tmp5.x, tmp6.x);
                tmp0.y = max(tmp0.z, tmp0.y);
                tmp2.z = 0.0;
                tmp4.xzw = tmp2.xzz;
                tmp5 = Load(rsc0, tmp4.xyz);
                tmp6 = tmp1.xyyx + int4(0, 3, 2, 3);
                tmp1.xy = tmp1.xy + int2(2, 2);
                tmp2.w = tmp6.w;
                tmp4.xz = tmp2.wz;
                tmp7 = Load(rsc0, tmp2.wyz);
                tmp2 = Load(rsc0, tmp2.xyz);
                tmp0.z = min(tmp7.x, tmp2.x);
                tmp2 = Load(rsc0, tmp4.xyz);
                tmp0.w = min(tmp5.x, tmp2.x);
                tmp0.z = min(tmp0.w, tmp0.z);
                tmp0.w = min(tmp0.z, tmp0.y);
                tmp0.y = max(tmp0.z, tmp0.y);
                tmp2.xzw = tmp3.xzz;
                tmp2.y = tmp6.y;
                tmp5 = Load(rsc0, tmp2.xyz);
                tmp6.y = tmp2.y;
                tmp6.w = 0.0;
                tmp2 = Load(rsc0, tmp6.xyw);
                tmp7 = Load(rsc0, tmp6.xzw);
                tmp3.w = tmp6.z;
                tmp3 = Load(rsc0, tmp3.xwz);
                tmp0.z = min(tmp3.x, tmp7.x);
                tmp2.x = min(tmp2.x, tmp5.x);
                tmp0.z = min(tmp0.z, tmp2.x);
                tmp0.w = min(tmp0.z, tmp0.w);
                tmp0.y = max(tmp0.z, tmp0.y);
                tmp6.xzw = tmp4.xzz;
                tmp2 = Load(rsc0, tmp6.xyz);
                tmp1.w = tmp6.y;
                tmp1.z = 0.0;
                tmp3 = Load(rsc0, tmp1.xwz);
                tmp5 = Load(rsc0, tmp1.xyz);
                tmp4.w = tmp1.y;
                tmp1 = Load(rsc0, tmp4.xwz);
                tmp0.z = max(tmp1.x, tmp5.x);
                tmp1.x = max(tmp2.x, tmp3.x);
                tmp0.z = max(tmp0.z, tmp1.x);
                tmp0.w = min(tmp0.z, tmp0.w);
                tmp0.y = max(tmp0.z, tmp0.y);
                o.sv_target.xyz = tmp0.xxx ? tmp0.www : tmp0.yyy;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
	}
}