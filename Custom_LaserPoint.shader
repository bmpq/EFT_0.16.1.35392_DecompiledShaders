Shader "Custom/LaserPoint" {
	Properties {
		[Queue] _MainTex ("Particle Texture", 2D) = "white" {}
		_NoiseTex ("Noise Texture (R)", 2D) = "white" {}
		[HDR] _Color ("Color", Color) = (1,1,1,1)
		_FactorOffset ("Z Offset Angle", Float) = 0
		_UnitsOffset ("Z Offset Forward", Float) = 0
		_Factor ("_Factor", Float) = 1
		_IkFactor ("_IkFactor", Float) = 1
		_MinFov ("_MinFov(fov when pointSize=0)", Float) = -50
		_SizeFactorViewMin ("_SizeFactorViewMin for ThirdParty view", Float) = 0.5
		_SizeFactorViewMax ("_SizeFactorViewMax for ThirdParty view", Float) = 2
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+2" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+2" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 8116
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float4 color : COLOR0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
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
