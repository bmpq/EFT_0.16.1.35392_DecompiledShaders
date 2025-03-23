Shader "Custom/SnowFlakes" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Scale ("Scale", Float) = 100
		_SideSpeed ("SideSpeed", Range(0, 0.2)) = 0.03
		_FallingVector ("_FallingVector", Vector) = (0,4,0,0)
		_ShadowOffset ("shadowOffset", Float) = 1
		_CameraPosShift ("CameraPosShift", Float) = -0.5
		_AlphaMult ("Alpha multiplier", Range(0, 20)) = 1
		_MinAmbient ("_MinAmbient", Float) = 1
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
		_NightVisionFactor ("_NightVisionFactor", Vector) = (0.3,0.3,0.3,0)
		_MinFOVValue ("_MinFOVValue", Float) = 4
		_MaxFOVValue ("_MaxFOVValue", Float) = 50
		_MinFOVFactor ("_MinFOVFactor", Float) = 4
		_MaxFOVFactor ("_MaxFOVFactor", Float) = 10
		_LightFilterFactor ("_LightFilterFactor", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Inpupe" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Fog {
				Mode 0
			}
			GpuProgramID 18099
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 color : COLOR0;
				float3 texcoord1 : TEXCOORD1;
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
