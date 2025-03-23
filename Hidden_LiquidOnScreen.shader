Shader "Hidden/LiquidOnScreen" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_DudvMap ("DuDv map", 2D) = "black" {}
		_Refraction ("Refraction", Float) = 0
		_Intensity ("Intensity", Range(0, 1)) = 0
		_Blured ("Blured", 2D) = "white" {}
		_inputMin ("Input Black", Vector) = (0,0,0,1)
		_inputMax ("Input White", Vector) = (1,1,1,1)
		_inputGamma ("Input Gamma", Vector) = (1,1,1,1)
		_outputMin ("Output Black", Vector) = (0,0,0,1)
		_outputMax ("Output White", Vector) = (1,1,1,1)
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Overlay" }
		Pass {
			LOD 200
			Tags { "RenderType" = "Overlay" }
			ZWrite Off
			GpuProgramID 48884
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
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
