Shader "Custom/Billboard_FogSheet_Simple" {
	Properties {
		_MainTex ("Texture Image", 2D) = "white" {}
		_Color ("Tint", Vector) = (0,0,0,1)
		_DiffuseIntensity ("Opacity Intensity", Float) = 1.9
		_DistanceFadingAlphaMax ("Max Distance Alpha", Range(0, 3)) = 1
		_DistanceFadingAlphaMultiplier ("Distance Alpha Multiplier", Range(0, 5)) = 1
		_DistanceFadingAlphaStartOffset ("Start Offset of Distance Alpha", Range(-20, 0)) = -0.2
		_WorldPositionOffsetAmount ("World Position Offset UV Amount (0-1)", Range(0, 1)) = 1
		_DiffuseScale ("Diffuse UV Scale", Float) = 1
		_UVOffsetX ("UV Offset X", Float) = 1
		_UVOffsetY ("UV Offset Y", Float) = 1
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_ScrollXSpeed ("X Scroll Speed", Range(0, 100)) = 0.1
		_ScrollYSpeed ("Y Scroll Speed", Range(0, 100)) = 0.1
		_AngleFadeStrengthFront ("AngleFade Front Strength", Range(0, 10)) = 5
		_AngleFadeStrengthBack ("AngleFade Back Strength", Range(0, 10)) = 5
		_DiffusePower ("Diffuse Contrast", Range(0, 3)) = 
		_NoiseForce ("Noise Power", Range(0, 500)) = 10
		_NoiseScale ("Noise Scale", Vector) = (10,10,0,0)
		_RadialPower ("Radial Contrast", Range(0, 10)) = 1
		_RadiusMultiplier ("Radius", Range(0, 25)) = 1
		_GradientPivot ("Position", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 19293
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float4 texcoord : TEXCOORD0;
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
