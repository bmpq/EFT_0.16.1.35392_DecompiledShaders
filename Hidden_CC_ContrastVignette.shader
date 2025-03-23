Shader "Hidden/CC_ContrastVignette" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Data ("Sharpness (X), Darkness (Y), Contrast (Z), Edge (W)", Vector) = (0.1,0.3,0.25,0.5)
		_Coeffs ("Luminance coeffs (RGB)", Vector) = (0.5,0.5,0.5,1)
		_Center ("Center point (XY)", Vector) = (0.5,0.5,1,1)
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 63809
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
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
