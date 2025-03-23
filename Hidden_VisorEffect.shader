Shader "Hidden/VisorEffect" {
	Properties {
		_MainTex ("_MainTex", 2D) = "white" {}
		_ScratchesTex ("_ScratchesTex", 2D) = "black" {}
		_GlassDamageTex ("_GlassDamageTex", 2D) = "black" {}
		_Mask ("_Mask", 2D) = "white" {}
		_BlurMask ("_BlurMask", 2D) = "black" {}
		_BlurTex ("_BlurTex", 2D) = "black" {}
		_DistortMask ("_DistortMask", 2D) = "black" {}
		_ScratcesIntensity ("_ScratcesIntensity", Float) = 1
		_InvMaskSize ("_InvMaskSize", Float) = 1
		_DistortIntensity ("_DistortIntensity", Float) = 1
		_Intensity ("_Intensity", Range(0, 1)) = 1
		_MinLightValue ("_MinLightValue", Range(0, 1)) = 0.15
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 11452
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
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
