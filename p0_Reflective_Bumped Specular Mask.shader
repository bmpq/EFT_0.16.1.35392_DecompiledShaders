Shader "p0/Reflective/Bumped Specular Mask" {
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
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_MaskTex ("MaskTex (R)", 2D) = "black" {}
		_DetailTex ("Detail (RGB) Gloss (A)", 2D) = "black" {}
		_DetailBumpMap ("Detail Normalmap", 2D) = "bump" {}
		_DetailGloss ("Detail Glossness", Range(0.01, 10)) = 1
		_DetailBumpStrength ("_DetailBumpStrength", Range(0, 1)) = 0.5
		_BumpTiling ("_BumpTiling", Float) = 1
		_DetailBumpTiling ("_DetailBumpTiling", Float) = 1
		_SSRPow ("SSR Power", Ran0, 1)) = 0
		_Temperature ("_Temperature", Vector) = (0.1,0.2,0.26,0)
	}
	SubShader {
		LOD 400
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 45981
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
				float4 texcoord6 : TEXCOORD6;
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
			sampler2D _DetailTex;
			sampler2D _MaskTex;
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _DetailBumpMap;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
