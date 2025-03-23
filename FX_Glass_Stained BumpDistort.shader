Shader "FX/Glass/Stained BumpDistort" {
	Properties {
		_BumpAmt ("Distortion", Range(0, 128)) = 10
		_MainTex ("Tint Color (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
		GrabPass {
		}
		Pass {
			Name "BASE"
			Tags { "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
			GpuProgramID 31174
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
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
