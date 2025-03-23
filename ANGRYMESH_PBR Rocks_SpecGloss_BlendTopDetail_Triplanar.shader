Shader "ANGRYMESH/PBR Rocks/SpecGloss_BlendTopDetail_Triplanar" {
	Properties {
		_BaseColor ("Base Color", Vector) = (1,1,1,0)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 0.078125
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.8,0.7,0,0)
		[NoScaleOffset] _BaseAlbedoASmoothness ("Base Albedo (A Specular)", 2D) = "gray" {}
		_SpecMap ("GlossMap", 2D) = "white" {}
		_BaseNormalIntensity ("Base Normal Intensity", Range(0, 2)) = 0.5
		_BaseNormalPower ("Base Normal Power/contrast", Range(0, 2)) = 1
		[NoScaleOffset] [Normal] _BaseNormalMap ("Base NormalMap", 2D) = "bump" {}
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
		[Toggle(_TOPNOISE_TRIPLANAR_ON)] _TopNoiseTriplanarEnabled ("Top Noise Triplanar?", Float) = 0
		[NoScaleOffset] _TopAlbedoASmoothness ("Top Albedo (A Smoothness)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _TopNormalMap ("Top NormalMap", 2D) = "bump" {}
		[Toggle(_DYNAMIC_UV_ON)] _DynamicUV ("Dynamic UV", Float) = 0
		_DetailAlbedoUVScale ("Detail Albedo UV Scale", Range(0, 40)) = 10
		_DetailNormalUVScale ("Detail Normal UV Scale", Range(0, 40)) = 10
		_TriplanarBlendSharpness ("Triplanar Blend Sharpness", Float) = 1
		_DetailAlbedoIntensity ("Detail Albedo Intensity", Range(0, 2)) = 0.6
		_DetailAlbedoMultiplier ("Detail Albedo Multiplier", Range(0, 2)) = 1
		_DetailAlbedoPower ("Detail Albedo Power", Range(0, 2)) = 1
		_DetailAlbedoSration ("Detail Albedo Saturation", Range(-1, 2)) = 1
		_DetailNormalMapIntensity ("Detail NormalMap Intensity", Range(0, 5)) = 1
		[Toggle(_TRIPLANAR_ALBEDO_DETAIL_ON)] _TriplanarAlbedoEnabled ("Triplanar albedo detail enabled", Float) = 0
		[NoScaleOffset] _DetailAlbedo ("Detail Albedo", 2D) = "gray" {}
		[Toggle(_TRIPLANAR_NORMAL_DETAIL_ON)] _TriplanarNormalEnabled ("Triplanar normal detail enabled", Float) = 0
		[NoScaleOffset] [Normal] _DetailNormalMap ("Detail NormalMap", 2D) = "bump" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
		[Space(30)] _Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 29611
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
			float _Specularness;
			float4 _SpecColor;
			float _Glossness;
			float3 _SpecVals;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _BaseNormalMap;
			sampler2D _DetailNormalMap;
			sampler2D _DetailAlbedo;
			sampler2D _BaseAlbedoASmoothness;
			sampler2D _TopAlbedoASmoothness;
			sampler2D _TopNormalMap;
			sampler2D _SpecMap;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
