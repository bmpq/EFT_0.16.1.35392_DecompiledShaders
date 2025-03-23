Shader "Hidden/PostProcessing/ScreenSpaceReflections" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 62684
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
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
                o.position.xy = v.vertex.xy;
                o.position.zw = float2(0.0, 1.0);
                tmp0 = v.vertex.xyxy + float4(1.0, 1.0, 1.0, 1.0);
                o.texcoord1 = tmp0 * float4(0.5, -0.5, 0.5, -0.5) + float4(0.0, 1.0, 0.0, 1.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
