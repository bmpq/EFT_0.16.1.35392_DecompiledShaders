Shader "Fake Interior/Interior" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("_StencilType", Float) = 0
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecMap ("GlossMap", 2D) = "white" {}
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Glossness", Range(0.01, 10)) = 1
		_Specularness ("Specularness", Range(0.01, 10)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		[Space] _ExteriorAtlasCellSize ("XY-Cell Coords, Z-Index", Vector) = (1,1,0,0)
		_MainTex ("Base (RGB) Specular (A)", 2D) = "white" {}
		_Transparent ("Transparent Glass", Range(0, 1)) = 0.5
		[Space] _Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_Temperature ("Temperature", Vector) = (0.1,0.2,0.28,0)
		[Space] [Header(Room Properties)] [Space] _BaseColor ("Base Color", Vector) = (1,1,1,1)
		_AdditionalColor ("Additional Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _CubemapArray ("Room Cubemap Atlas", CubeArray) = "black" {}
		_LayerIndex ("Layer Index", Vector) = (0,2,0,0)
		_InteriorTilingOffset ("Tiling Offset", Vector) = (1,1,0,0)
		[Space] _DistortPerspective ("Distort Perspective - Width | Height", Vector) = (1,1,0,0)
		_WidthHeight ("Width | Height", Vector) = (1,1,0,0)
		[Header(Random)] [Space] _Seed ("Seed", Range(0, 1)) = 0
		_FrequencyRandom ("Frequency", Range(0, 1)) = 0.5
		[Header(Depth)] [Space] _DepthScale ("Scale", Range(0.001, 5)) = 1
		_DepthOffset ("Offset", Range(0.01, 1)) = 1
		_FrequencyDepth ("Frequency", Range(0, 1)) = 0.5
		[Header(Emission)] [Space] _EmissionPower ("Power", Range(0, 8)) = 1
		_EmissionBaseLine ("Base Line", Range(0, 1)) = 0.5
		_FrequencyEmission ("Frequency", Range(0, 1)) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			"UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float3 normal : NORMAL0;
				float3 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float3 texcoord7 : TEXCOORD7;
				float3 texcoord8 : TEXCOORD8;
				float3 texcoord9 : TEXCOORD9;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _LayerIndexOffset;
			float3 _SpecVals;
			float _Specularness;
			float3 _DefVals;
			float _Glossness;
			float4 _Temperature;
			float4 _InteriorTilingOffset;
			float4 _BaseColor;
			float4 _AdditionalColor;
			float4 _ExteriorAtlasCellSize;
			float4 _ReflectColor;
			float2 _WidthHeight;
			float2 _LayerIndex;
			float _ThermalVisionOn;
			float _DepthOffset;
			float _EmissionBaseLine;
			float _EmissionPower;
			float _TODEmissionMultiplier;
			float _FrequencyRandom;
			float _FrequencyDepth;
			float _Seed;
			float _Transparent;
			float _FrequencyEmission;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			UNITY_DECLARE_TEXCUBEARRAY(_CubemapArray);
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
