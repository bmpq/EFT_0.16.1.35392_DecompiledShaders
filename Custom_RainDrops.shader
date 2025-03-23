Shader "Custom/RainDrops" {
	Properties {
		[Queue] _MainTex ("Base (RGB)", 2D) = "white" {}
		_Scale ("Scale", Float) = 100
		_Size ("_Size", Vector) = (0.021,0.026,0,0)
		_SideSpeed ("SideSpeed", Range(0, 0.2)) = 0.03
		_FallingVector ("_FallingVector", Vector) = (0,4,0,0)
		_ShadowOffset ("shadowOffset", Float) = 1
		_CameraPosShift ("CameraPosShift", Float) = -0.5
		_AlphaMult ("Alpha multiplier", Range(0, 20)) = 1
		_MinAmbient ("_MinAmbient", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Fog {
				Mode 0
			}
			GpuProgramID 23516
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 color : COLOR0;
				float3 texcoord1 : TEXCOORD1;
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
