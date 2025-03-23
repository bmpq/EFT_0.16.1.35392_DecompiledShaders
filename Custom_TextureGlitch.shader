Shader "Custom/TextureGlitch" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecMap ("SpecularMap (R)", 2D) = "white" {}
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Glossness", Range(0.01, 10)) = 1
		_Specularness ("Specularness", Range(0.01, 10)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_EmissionMap ("EmissionMap", 2D) = "white" {}
		_EmissionVisibility ("EmissionVisibility", Range(0, 1)) = 1
		_EmissionPower ("EmissionPower", Range(0, 10)) = 1
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_BumpTiling ("_BumpTiling", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_DispTex ("Displacement Map", 2D) = "bump" {}
		_DigitalMistakeIntensity ("_DigitalMistakeIntensity", Range(0, 1)) = 0.007
		lorSwitchFilterRadius ("_ColorSwitchFilterRadius", Range(0, 10)) = 2
		_ScanLineJitter ("_ScanLineJitter (displacement, threshold)", Vector) = (0.05,0.7,0,0)
		_VerticalJump ("_VerticalJump (amount, scale)", Vector) = (0.1,7,0,0)
		_HorizontalShake ("_HorizontalShake", Range(0, 1)) = 0
		_ColorDrift ("_ColorDrift", Range(0, 1)) = 0.002
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 23015
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord7 : TEXCOORD7;
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
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _DispTex;
			sampler2D _EmissionMap;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
