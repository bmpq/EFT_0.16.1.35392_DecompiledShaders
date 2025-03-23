Shader "ANGRYMESH/PBR Rocks/PBR BlendTopDetail (Legacy)" {
	Properties {
		_BaseSmoothness ("Base Smoothness", Range(0, 1)) = 0.5
		_BaseAOIntensity ("Base AO Intensity", Range(0, 1)) = 0.5
		_BaseColor ("Base Color", Vector) = (1,1,1,0)
		[NoScaleOffset] _BaseAlbedoASmoothness ("Base Albedo (A Smoothness)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _BaseNormalMap ("Base NormalMap", 2D) = "bump" {}
		_BaseNormalIntensity ("Base Normal Intensity", Range(0, 2)) = 0.5
		_BaseNormalPower ("Base Normal Power/contrast", Range(0, 2)) = 1
		[NoScaleOffset] _BaseAOANoiseMask ("Base AO (A NoiseMask)", 2D) = "white" {}
		[Toggle(_TOPNOISE_ON)] _TopNoise ("Top Noise", Float) = 0
		_TopNoiseUVScale ("Top Noise UV Scale", Range(0.2, 10)) = 1
		_TopSmoothness ("Top Smoothness", Range(0, 1)) = 1
		_TopUVScale ("Top UV Scale", Range(1, 30)) = 10
		_TopIntensity ("Top Intensity", Range(0, 1)) = 0
		_TopOffset ("Top Offset", Range(0, 1)) = 0.5
		_TopContrast ("Top Contrast", Range(0, 2)) = 1
		_TopNormalIntensity ("Top Normal Intensity", Range(0, 2)) = 1
		_TopColor ("Top Color", Vector) = (1,1,1,0)
		[NoScaleOffset] _TopAlbedoASmoothness ("Top Albedo (A Smoothness)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _TopNormalMap ("Top NormalMap", 2D) = "bump" {}
		_DetailUVScale ("Detail UV Scale", Range(0, 40)) = 10
		_DetailAlbedoIntensity ("Detail Albedo Intensity", Range(0, 1)) = 1
		_DetailNormalMapIntensity ("Detail NormalMap Intensity", Range(0, 2)) = 1
		_DetailNormalUVScale ("Detail Normal UV Scale", Range(0, 40)) = 10
		[NoScaleOffset] _DetailAlbedo ("Detail Albedo", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _DetailNormalMap ("Detail NormalMap", 2D) = "bump" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
		[Space(30)] _Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void true" }
			GpuProgramID 65255
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord6 : TEXCOORD6;
				float4 texcoord7 : TEXCOORD7;
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
			sampler2D _BaseNormalMap;
			sampler2D _BaseAOANoiseMask;
			sampler2D _DetailNormalMap;
			sampler2D _TopNormalMap;
			sampler2D _BaseAlbedoASmoothness;
			sampler2D _DetailAlbedo;
			sampler2D _TopAlbedoASmoothness;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
