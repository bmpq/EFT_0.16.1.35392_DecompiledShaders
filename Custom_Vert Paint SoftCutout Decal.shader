Shader "Custom/Vert Paint SoftCutout Decal" {
	Properties {
		[Queue] [Toggle(ALPHA_HEIGHT)] _AlphaHeight ("Alpha Height", Float) = 0
		_BlendStrength ("Blend Strength", Range(0.1, 30)) = 1
		_AlphaStrength ("Alpha Strength", Range(0.1, 30)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color0 ("Main Color 0", Vector) = (1,1,1,1)
		_MainTex0 ("Base (RGB) Smoothness (A) 0", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap0 ("Normalmap 0", 2D) = "bump" {}
		_Smoothness0 ("Smoothness 0", Range(0, 1)) = 0
		_Specular0 ("Specular 0", Range(0, 1)) = 0
		_FresnelDiffuse0 ("Fresnel Diffuse 0", Range(0, 1)) = 0
		_FresnelSpecular0 ("Fresnel Specular 0", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color1 ("Main Color 0", Vector) = (1,1,1,1)
		_MainTex1 ("Base (RGB) Smoothness (A) 1", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap1 ("Normalmap 1", 2D) = "bump" {}
		_Smoothness1 ("Smoothness 1", Range(0, 1)) = 0
		_Specular1 ("Specular 1", Range(0, 1)) = 0
		_FresnelDiffuse1 ("Fresnel Diffuse 1", Range(0, 1)) = 0
		_FresnelSpecular1 ("Fresnel Specular 1", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color2 ("Main Color 0", Vector) = (1,1,1,1)
		_MainTex2 ("Base (RGB) Smoothness (A) 2", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap2 ("Normalmap 2", 2D) = "bump" {}
		_Smoothness2 ("Smoothness 2", Range(0, 1)) = 0
		_Specular2 ("Specular 2", Range(0, 1)) = 0
		_FresnelDiffuse2 ("Fresnel Diffuse 2", Range(0, 1)) = 0
		_FresnelSpecular2 ("Fresnel Specular 2", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Heights ("Heights", 2D) = "white" {}
		_ReflectionStrength ("GI And Reflection Strength", Fl) = 1
		_Cutoff ("_Cutoff", Float) = 0.85
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.44,0)
	}
	SubShader {
		Tags { "DisableBatching" = "true" "FORCENOSHADOWCASTING" = "true" "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
		Pass {
			Name "DEFERRED"
			Tags { "DisableBatching" = "true" "FORCENOSHADOWCASTING" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 49880
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
				float4 color : COLOR0;
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
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _Heights;
			sampler2D _MainTex0;
			sampler2D _MainTex1;
			sampler2D _MainTex2;
			sampler2D _BumpMap0;
			sampler2D _BumpMap1;
			sampler2D _BumpMap2;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
