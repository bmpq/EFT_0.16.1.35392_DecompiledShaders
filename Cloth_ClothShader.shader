Shader "Cloth/ClothShader" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_GlossMap ("Gloss map", 2D) = "white" {}
		_NoiseTex ("Vertex Noise texture", 2D) = "grey" {}
		_NormalMap1 ("NormalMap", 2D) = "bump1" {}
		_NormalMap2 ("NormalMap", 2D) = "bump2" {}
		_NormalsMask ("Normals Mask", 2D) = "normalmask" {}
		_CutoutMask ("Cutout Mask", 2D) = "cutoutmask" {}
		_CutoutMaskUVScale ("Cutout mask UV coordinates scale", Float) = 1
		_Glossiness ("Smoothness", Range(-1, 1)) = 0.5
		_Metallic ("Metallic", Range(-1, 1)) = 0
		_ScrollXSpeed ("X Scroll Speed", Range(0, 1)) = 0.1
		_ScrollYSpeed ("Y Scroll Speed", Range(0, 1)) = 0.1
		_ScrollSpeedRandomFactor ("Scroll Speed Random Factor", Float) = 1
		_NormalBlendingRandomFactor ("Normal blending factor", Float) = 1
		_VertexTimeOffset ("VertexOffset", Float) = 1
		_NormalBlendThreshold ("Normal blend threshold", Float) = 1
		_VertexAnimationScale ("Vertex animation strength", Float) = 0
		_VertexAnimationSpeedMltiplier ("Vertex animation speed", Float) = 1
		_CutOff ("Cut off", Range(0, 1)) = 0
		[Space(30)] _Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 19585
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
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
			sampler2D _MainTex;
			sampler2D _CutoutMask;
			sampler2D _GlossMap;
			sampler2D _NormalMap1;
			sampler2D _NormalMap2;
			sampler2D _NormalsMask;
			sampler2D unity_NHxRoughness;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
