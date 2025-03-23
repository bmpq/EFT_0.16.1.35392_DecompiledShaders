Shader "Hidden/ProBuilder/FacePicker" {
	Properties {
	}
	SubShader {
		Tags { "LIGHTMODE" = "ALWAYS" "ProBuilderPicker" = "Base" }
		Pass {
			Name "Base"
			Tags { "LIGHTMODE" = "ALWAYS" "ProBuilderPicker" = "Base" }
			GpuProgramID 13511
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 color : COLOR0;
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
