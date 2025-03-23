Shader "Hidden/StencilShadow" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
			ColorMask 0
			ZClip Off
			ZTest Greater
			ZWrite Off
			Stencil {
				Comp Always
				Pass DecrementSaturate
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 39350
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
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
