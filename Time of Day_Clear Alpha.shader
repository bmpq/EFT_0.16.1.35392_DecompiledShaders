Shader "Time of Day/Clear Alpha" {
	Properties {
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+510" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+510" "RenderType" = "Background" }
			ColorMask A
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 19168
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
