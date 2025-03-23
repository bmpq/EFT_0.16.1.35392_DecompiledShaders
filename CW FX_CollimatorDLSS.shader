Shader "CW FX/CollimatorDLSS" {
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
			ZWrite Off
			Cull Off
			GpuProgramID 50234
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
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
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
