Shader "EFT/Snow Sparkling" {
	Properties {
		_MainTex ("Sparkle", 2D) = "white" {}
		[Space(10)] _SpriteSize ("Sprite Size", Vector) = (0.01,0.01,0,0)
		_SparklingsIntensity ("Sparklings Intensity", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent+10" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent+10" }
			Blend SrcAlpha One, Zero One
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 3
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 60328
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float texcoord1 : TEXCOORD1;
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
