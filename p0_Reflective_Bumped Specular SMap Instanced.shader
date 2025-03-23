Shader "p0/Reflective/Bumped Specular SMap Instanced" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _SpecMap ("GlossMap (R)", 2D) = "white" {}
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Specular (A)", 2D) = "white" {}
		[NoScaleOffset] _Cube ("Reflection Cubemap", Cube) = "" {}
		[NoScaleOffset] _BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		[NoScaleOffset] _DetailArray ("Detail Array", 2DArray) = "" {}
		[NoScaleOffset] _Mask ("Mask (R)", 2D) = "white" {}
		_BumpTiling ("_BumpTiling", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_DropsSpec ("Drops spec", Float) = 128
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScal Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
		_NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOffset ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 28225
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
			float _ThermalVisionOn;
			float4 _Temperature2;
			float4 _Color;
			float4 _ReflectColor;
			float _Specularness;
			float _Glossness;
			float3 _SpecVals;
			float3 _DefVals;
			float _BumpTiling;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			CBUFFER_START(Props)
			CBUFFER_END
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _Mask;
			samplerCUBE _Cube;
			UNITY_DECLARE_TEX2DARRAY(_DetailArray);
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
