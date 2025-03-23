Shader "CW FX/Collimator" {
	Properties {
		_Color ("Color", Color) = (0.5,0.5,0.5,0.1)
		_NoiseTex ("Noise Texture (R)", 2D) = "white" {}
		_MarkTex ("Mark Texture (A)", 2D) = "white" {}
		_FadeTex ("Fade Texture (R)", 2D) = "white" {}
		_MarkShift ("Mark Shift", Vector) = (0,0,0,0)
		_MarkScale ("Mark Scale", Float) = 0
		_HDR ("HDR", Float) = 4
	}
	SubShader {
		Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay+11" "RenderType" = "Transparent" }
		Pass {
			Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Overlay+11" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 43582
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
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
