Shader "Time of Day/Cloud Layer 2" {
	Properties {
		_CloudColor ("Cloud Color", Vector) = (1,1,1,1)
		_MapLow ("_MapLow", 2D) = "white" {}
		_MapHigh ("_MapHigh", 2D) = "white" {}
		_Noise ("_Noise", 2D) = "white" {}
		[Space(32)] _CloudRoughnessMin ("_RoughnessMin", Range(0, 1)) = 1
		_CloudNoiseMapRoughness ("_NoiseMapRoughness", Range(0, 1)) = 1
		_CloudDensity ("_Density", Range(-1, 1)) = 1
		[Space(16)] [HDR] _SunMultyplyer ("_SunMultyplyer", Vector) = (1,1,1,1)
		_ForwardLight ("_ForwardLight", Float) = 1
		_ForwardLightWidth ("_ForwardLightWidth", Range(0, 1)) = 1
		[Space(8)] _SunScattering ("_SunScattering", Float) = 1
		_MoonScattering ("_MoonScattering", Float) = 1
		_SkyScattering ("_SkyScattering", Float) = 1
		[Space(8)] [HDR] _BottomReflections ("_BottomReflections", Vector) = (1,1,1,1)
		[Space(16)] _CloudDisplacementNormal ("_DisplacementNormal", Float) = 1
		_DisplacementScattering ("_DisplacementScattering", Float) = 1
		_FogDensity ("_FogDensity", Float) = 0.15
		_CloudCurviness ("_Curvin", Float) = 1
		_CloudScale ("_Scale", Float) = 0.1
		_CloudPosition ("_CloudPosition", Vector) = (0,0,0,0)
		_HorizontToAlphaFadingIntensity ("_HorizontToAlphaFadingIntensity", Float) = 32
		_HorizontToAlphaFadingPosition ("_HorizontToAlphaFadingPosition", Float) = -0.2
		_PlanetSize ("_PlanetSize", Float) = 3
		_LerpToAtmosphere ("_LerpToAtmosphere", Range(0, 1)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+520" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+520" "RenderType" = "Background" }
			Blend SrcAlpha OneMinusSrcAlpha, One Zero
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 37979
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 normal : NORMAL0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
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
