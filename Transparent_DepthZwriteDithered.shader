Shader "Transparent/DepthZwriteDithered" {
	Properties {
		[MaterialEnum(Off,0,Front,1,Back,2)] _Cull ("Cull", Float) = 2
		[MaterialEnum(Transparent, 0, Tinted, 1)] _Tinted ("Tint", Float) = 0
		[Toggle(_ALPHA_PARALLAX_ON)] _UseDetailMaps ("Use parallax for alpha", Float) = 0
		_FrontParallax ("Front face parallax scale", Range(0, 20)) = 3
		_BackParallax ("Back face parallax scale", Range(0, 20)) = 2
		_Color ("Main Color", Vector) = (1,1,1,1)
		_OpacityScale ("Opacity scale", Range(0, 4)) = 1
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_SpecTex ("Specular (R), Gloss (A)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_SpecPower ("Specular Power", Range(0.01, 10)) = 1
		_Glossness ("Glossness", Range(0.01, 50)) = 1
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_GlobeflectionStrength ("_GlobalReflectionStrength", Float) = 1
		[Toggle(_ADDITIONAL_REFLECTION)] _AdditionalReflection ("Add fake reflection", Float) = 0
		_AdditionalReflectionStrength ("_AdditionalReflectionStrength", Float) = 0
		_Temperature ("_Temperature", Vector) = (0.1,0.5,0.5,0)
	}
	SubShader {
		Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
		Pass {
			Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
			ColorMask A
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 368120
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 color : COLOR0;
				float4 position : SV_POSITION0;
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
