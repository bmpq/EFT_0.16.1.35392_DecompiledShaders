Shader "Time of Day/Skybox" {
	Properties {
	}
	SubShader {
		Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
		Pass {
			Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
			ZWrite Off
			Cull Off
			GpuProgramID 43032
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float TOD_Brightness;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
