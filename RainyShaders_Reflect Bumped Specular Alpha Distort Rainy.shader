Shader "RainyShaders/Reflect Bumped Specular Alpha Distort Rainy" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_RainFlow ("RainFlow", 2D) = "black" {}
		_RainGradient ("RainGradient", 2D) = "black" {}
		_RainPower ("RainPower", Range(0, 1)) = 1
		_RainSpeed ("RainSpeed", Range(0, 2)) = 1
		_RainTilingX ("RainTilingX", Float) = 1
		_RainTilingY ("RainTilingY", Float) = 1
		_fallow ("_RimReflection", Range(0.01, 1.5)) = 1
		_level ("_RimReflection_2", Range(0.01, 1.5)) = 1
		_Distort ("Distort", Range(0.03, 1.5)) = 0.03
		_WaterContrast ("WaterContrast", Range(0, 1)) = 0.5
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface bTexture"
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Fog {
				Mode 0
				Color (1,1,1,0)
			}
			GpuProgramID 16536
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord8 : TEXCOORD8;
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
