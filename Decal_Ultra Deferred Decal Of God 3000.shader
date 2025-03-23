Shader "Decal/Ultra Deferred Decal Of God 3000" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,0)
		[HDR] _EmissionColor ("Emission", Color) = (0,0,0,0)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_NormalIntensity ("Normal Intensity", Range(0, 1)) = 0
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature ("_Temperature", Vector) = (0.1,0.12,0.28,0)
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+5" "RenderType" = "Transparent" }
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero One
			ZWrite Off
			GpuProgramID 51981
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float4 _Color;
			float4 _EmissionColor;
			float _NormalIntensity;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
