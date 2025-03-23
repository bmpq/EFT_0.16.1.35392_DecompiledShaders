Shader "Hidden/AnalyticSource" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
			Blend DstColor Zero, DstColor Zero
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 42012
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
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
