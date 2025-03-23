Shader "Hidden/Desaturate Effect" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RampTex ("Base (RGB)", 2D) = "grayscaleRamp" {}
		_DesatWeather ("Desaturate Weather", Float) = 0.5
		_DesatHealth ("Desaturate Health", Float) = 0.5
		_DesatMask ("Desaturate Mask", Float) = 1
		_Radius ("Radius", Range(0, 1)) = 1
		_RadiusFalloff ("Radius Falloff", Range(0, 1)) = 0.425
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 29174
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
