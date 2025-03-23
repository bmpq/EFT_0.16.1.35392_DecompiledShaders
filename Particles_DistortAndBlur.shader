Shader "Particles/DistortAndBlur" {
	Properties {
		_DistortTex ("_DistortTex", 2D) = "white" {}
		_AlphaTex ("_AlphaTex", 2D) = "white" {}
		_Distort ("Distortion Strength", Range(0, 1)) = 1
		_Blur ("Blur Strength", Range(0, 1)) = 1
		_InvFade ("Soft Particles Factor", Range(0.01, 500)) = 1
		_TextureMovement ("TextureMovement", Vector) = (1,1,-1,-1)
	}
	SubShader {
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			GpuProgramID 65310
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 color : COLOR0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
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
