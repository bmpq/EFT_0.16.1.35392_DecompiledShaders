Shader "Time of Day/Cloud Layer" {
	Properties {
		_MainTex ("Alpha Layers (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_PlanetSize ("_PlanetSize", Float) = 3
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+520" "RenderType" = "Background" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background+520" "RenderType" = "Background" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Front
			Fog {
				Mode 0
			}
			GpuProgramID 29186
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float3 TOD_SunCloudColor;
			float3 TOD_MoonCloudColor;
			float TOD_CloudSharpness;
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
