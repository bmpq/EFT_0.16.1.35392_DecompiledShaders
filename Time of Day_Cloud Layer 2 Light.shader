Shader "Time of Day/Cloud Layer 2 Light" {
	Properties {
		_CloudColor ("Cloud Color", Vector) = (1,1,1,1)
		[HDR] _LightColor ("_LightColor", Vector) = (1,1,1,1)
		_MapLow ("_MapLow", 2D) = "white" {}
		_MapHigh ("_MapHigh", 2D) = "white" {}
		_Noise ("_Noise", 2D) = "white" {}
		_LightMap ("_LightMap", 2D) = "white" {}
		_MapSize ("_MapSize", Float) = 1
		[Space(32)] _CloudRoughnessMin ("_RoughnessMin", Range(0, 1)) = 1
		_CloudNoiseMapRoughness ("_NoiseMapRoughness", Range(0, 1)) = 1
		_CloudDensity ("_Density", Range(-1, 1)) = 1
		[Space(16)] _Light ("_Light", Float) = 1
		[Space(16)] _DisplacementNormal ("_DisplacementNormal", Float) = 1
		_FogDensity ("_FogDensity", Float) = 0.15
		_CloudCurviness ("_Curviness", Float) = 1
		_CloudScale ("_Scale", Float) = 1
		_CloudPosition ("_CloudPosition", Vector) = (0,0,0,0)
		_RealHeight ("_RealHeight", Float) = 1
		_MapTransform ("_MapTransform", Vector) = (0,0,0,0)
		_DetailAdd ("_DetailAdd", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderT "Geometry+530" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+530" "RenderType" = "Background" }
			Blend One One, One One
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 47168
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 normal : NORMAL0;
				float texcoord4 : TEXCOORD4;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float2 texcoord3 : TEXCOORD3;
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
