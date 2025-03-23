Shader "Custom/MuzzleSmoke" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Alpha ("_Alpha", Float) = 1
		_Width ("_Width", Float) = 1
		_UVYScale ("_UVYScale", Float) = 0.1
		_DiffusionStrength ("_DiffusionStrength", Float) = 0.1
		_StartFade ("_StartFade", Float) = 1
		_EndFade ("_EndFade", Float) = 1
		_End ("_End", Float) = 4
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 11552
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float color : COLOR0;
				float4 texcoord2 : TEXCOORD2;
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
