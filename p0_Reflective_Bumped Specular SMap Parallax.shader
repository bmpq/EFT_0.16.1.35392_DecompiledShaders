Shader "p0/Reflective/Bumped Specular SMap Parallax" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecMap ("GlossMap", 2D) = "white" {}
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Specular (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_BumpTiling ("_BumpTiling", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_DropsSpec ("Drops spec", Float) = 128
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScale", Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
		_NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOft ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
		_Parallax ("Height", Range(0.005, 0.08)) = 0.02
		_ParallaxMap ("Heightmap (R)", 2D) = "black" {}
		_Temperature ("_Temperature", Vector) = (0.1,0.5,0.5,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 14818
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
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _ParallaxMap;
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
