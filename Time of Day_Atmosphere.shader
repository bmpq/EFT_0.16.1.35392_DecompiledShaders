Shader "Time of Day/Atmosphere" {
	Properties {
		_DitheringTexture ("Dithering Lookup Texture (A)", 2D) = "black" {}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+40" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+40" "RenderType" = "Background" }
			Blend One One, One One
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 24152
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord2 : TEXCOORD2;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float TOD_MoonHaloPower;
			float3 TOD_MoonSkyColor;
			float3 TOD_GroundColor;
			float3 TOD_MoonHaloColor;
			float3 TOD_kBetaMie;
			float3 TOD_LocalMoonDirection;
			float TOD_Contrast;
			float TOD_ScatteringBrightness;
			float TOD_Fogginess;
			// $Globals ConstantBuffers for Fragment Shader
			float TOD_Brightness;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
