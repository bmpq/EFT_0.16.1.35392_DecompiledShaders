Shader "Custom/SimpleParticleMoveAdd" {
	Properties {
		[Queue] [HDR] _TintColor ("Tint Color (HDR)", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Texture", 2D) = "white" {}
		_Size ("Size", Float) = 1
		[Toggle(TURBULENCE)] _Turbulence ("Turbulence", Float) = 0
		[Space(8)] _TurbulenceFrequency0 ("Turbulence Frequency 0", Float) = 0
		_TurbulenceAmplitude0 ("Turbulence Amplitude 0", Float) = 0
		[Space(8)] _TurbulenceFrequency1 ("Turbulence Frequency 1", Float) = 0
		_TurbulenceAmplitude1 ("Turbulence Amplitude 1", Float) = 0
		[Space(16)] _FadeOut ("Fade Out Turbulence (1/sec)", Float) = 16
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 34144
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float color : COLOR0;
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
