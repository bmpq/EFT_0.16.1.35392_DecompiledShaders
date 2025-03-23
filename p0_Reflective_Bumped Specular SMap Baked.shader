Shader "p0/Reflective/Bumped Specular SMap Baked" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("_StencilType", Float) = 0
		_Color ("Main Color", Vector) = (1,1,1,1)
		_BaseTintColor ("Tint Color", Vector) = (1,1,1,1)
		_SpecMap ("GlossMap", 2D) = "white" {}
		_SpecColor ("Specular Color", Vector) = (1,1,1,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 1
		_ReflectColorMap ("Reflection Color Map", 2D) = "white" {}
		_MainTex ("Base (RGB) Specular (A)", 2D) = "white" {}
		[Toggle(TINTMASK)] _HasTint ("Has tint", Float) = 0
		_TintMask ("Tint mask", 2D) = "black" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_Cube2 ("Reflection Cubemap 2", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (2,1,3,1)
		_DefVals ("Defuse Vals", Vector) = (1,0.4,1,0.4)
		_CutoutValue ("Cutout", Range(0, 1)) = 0.5
		_BumpTiling ("_BumpTiling", Float) = 1
		_NormalIntensity ("Normal intensity", Float) = 1
		_NormalUVMultiplier ("Normal UV tiling", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_DropsSpec ("Drops spec", Float) = 128
		_Temperature ("_Temperature", Vector) = (0.1,0.3,0.35,0)
		_Temperature2 ("_Temperature2", Vector) = (0.1,0.2,0.28,0)
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScale", Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
		_NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOffset ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
		[Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		_HeatVisible ("_HeatVisible([0-1] for thermalVision only)", Float) = 1
		[HDR] _HeatColor1 ("_HeatColor1", Vector) = (1,0,0,1)
		[HDR] _HeatColor2 ("_HeatColor2", Vector) = (1,0.34,0,1)
		_HeatCenter ("_HeatCenter", V) = (0,0,0,1)
		_HeatSize ("_HeatSize", Vector) = (0.02,0.04,0.02,1)
		_HeatTemp ("_HeatTemp", Float) = 0
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			ColorMask RGB
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 1812
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
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord8 : TEXCOORD8;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _CutoutValue;
			float _HeatThermalFactor;
			float4 _Color;
			float _Specularness;
			float _Glossness;
			float _NormalIntensity;
			float _NormalUVMultiplier;
			float4 _SpecVals;
			float4 _DefVals;
			float _BumpTiling;
			float4 _Temperature;
			float4 _Temperature2;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _ReflectColorMap;
			samplerCUBE _Cube2;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
