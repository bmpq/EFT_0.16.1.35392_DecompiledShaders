Shader "Custom/GradingPostFX" {
	Properties {
		_MainTex ("_MainTex", 2D) = "white" {}
		_ColorStrength ("ColorStrength", Vector) = (0.2,0.2,0.2,1)
		_Brightness ("Brightness", Range(0.5, 1.5)) = 1
		_Saturation ("Saturation", Range(0, 1.5)) = 1
		_Strength ("Strength", Range(0, 1)) = 1
		_SharpStrength ("SharpStrength", Range(0.1, 3)) = 0.65
		_SharpClamp ("SharpClamp", Range(0, 1)) = 0.035
		_SharpPattern ("Fast - 0, Normal - 1, Wider - 2, Pyramid - 3", Float) = 0
		_OffsetBias ("OffsetBias", Range(0, 6)) = 1
		[Toggle(SHOW_SHARPEN)] _ShowSharpen ("ShowSharpen", Float) = 0
		_ClarityRadius ("ClarityRadius (Int value)", Range(0, 4)) = 3
		_ClarityOffset ("ClarityOffset (Int value)", Range(1, 5)) = 2
		_ClarityBlendMode ("Soft Light - 0, Overlay - 1, Hard Light - 2, Multiply - 3, Vivid Light - 4, Linear Light - 5, Addition - 6", Float) = 2
		_ClarityBlendIfDark ("ClarityBlendIfDark", Range(0, 255)) = 50
		_ClarityBlendIfLight ("ClarityBlendIfLight", Range(0, 255)) = 205
		[Toggle(CLARITY_VIEWBLEND_MASK)] _ClarityViewBlendIfMask ("ClarityViewBlendIfMask", Float) = 0
		_ClarityStrength ("ClarityStrength", Range(0, 1)) = 0.4
		_ClarityDarkIntensity ("ClarityDarkIntensity", Range(0, 1)) = 0.4
		_ClarityLightIntensity ("ClarityLightIntensity", Range(0, 1)) = 0
		[Toggle(CLARITY_VIEW_MASK)] _ClarityViewMask ("ClarityViewMask", Float) = 0
		_Colourfulness ("Colourfulness, 0 = neutral", Range(0.1, 1)) = 0.4
		_LimLuma ("LimLuma", Range(0.1, 1)) = 0.7
		[Toggle(ENABLE_DITHER)] _EnableDither ("EnableDither", Float) = 0
		[Toggle(COL_NOISE)] _ColNoise ("ColNoise", Float) = 1
		_BackbufferBits ("BackbufferBits", Range(1, 32)) = 8
		_CurveHeight ("CurveHeight", Range(0.01, 2)) = 1
		_Curveslope ("Curveslope", Range(0.01, 2)) = 0.5
		_LOvershoot ("LOvershoot", Range(0.001, 0.1)) = 0.003
		_LComprLow ("LComprLow", Range(0, 1)) = 0.167
		_LComprHigh ("LComprHigh", Range(0, 1)) = 0.334
		_DOvershoot ("DOvershoot", Range(0.01, 0.1)) = 0.009
		_DComprLow ("DComprLow", Range(0, 1)) = 0.25
		_DComprHigh ("DComprHigh", Range(0, 1)) = 0.5
		_ScaleLim ("ScaleLim", Range(0, 1)) = 0.1
		_ScaleCs ("ScaleCs", Range(0, 1)) = 0.056
		_PmP ("PmP", Range(0.01, 1)) = 0.7
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 23346
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
