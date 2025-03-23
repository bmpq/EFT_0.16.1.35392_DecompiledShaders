Shader "Time of Day/Sun" {
	Properties {
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+120" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+120" "RenderType" = "Background" }
			ZWrite Off
			Fog {
				Mode 0
			}
			GpuProgramID 19584
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
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
