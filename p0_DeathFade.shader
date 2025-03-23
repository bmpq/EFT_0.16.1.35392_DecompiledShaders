Shader "p0/DeathFade" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Value ("Value", Range(0, 1)) = 1
		_A ("A", Range(0, 1.5)) = 0.8
		_Color ("Color", Color) = (0,0,0,0)
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Transparent" }
		Pass {
			LOD 200
			Tags { "RenderType" = "Transparent" }
			GpuProgramID 887
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float2 texcoord : TEXCOORD0;
				float4 sv_position : SV_Position0;
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
