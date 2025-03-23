Shader "Hidden/Grayscale" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_EffectAmount ("Grayscale Value", Float) = 0
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Opaque" }
		Pass {
			LOD 200
			Tags { "RenderType" = "Opaque" }
			GpuProgramID 5215
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
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
