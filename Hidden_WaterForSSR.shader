Shader "Hidden/WaterForSSR" {
	Properties {
		_RippleTex ("_RippleTex", 2D) = "black" {}
		_FoamTex ("_FoamTex", 2D) = "white" {}
		_BumpMap ("_BumpMap", 2D) = "white" {}
		_BumpMapDetails ("_BumpMapDetails", 2D) = "white" {}
		_DepthVals ("_DepthVals", Vector) = (1,1,1,1)
		_Bumpiness ("_Bumpiness", Float) = 1
		_TexturesScales ("_TexturesScales", Vector) = (1,1,1,1)
		_TexturesTimeScales ("_TexturesTimeScales", Vector) = (1,1,1,1)
		_DepthColorDeep ("_DepthColorDeep", Vector) = (1,1,1,1)
		_DepthColorShallow ("_DepthColorShallow", Vector) = (1,1,1,1)
		_ValsNormA ("_ValsNormA", Vector) = (0,0,0,0)
		_ValsNormB ("_ValsNormB", Vector) = (0,0,0,0)
		_ValsNormD ("_ValsNormD", Vector) = (0,0,0,0)
		_ValsFoamA ("_ValsFoamA", Vector) = (0,0,0,0)
		_ValsFoamB ("_ValsFoamB", Vector) = (0,0,0,0)
		_FoamVals ("_FoamVals", Vector) = (1,1,1,1)
		_FresnelVals ("_FresnelVals", Vector) = (1,1,1,1)
		_FoamColor ("_FoamColor", Vector) = (1,1,1,1)
		_RippleScale ("_RippleScale", Float) = 1
		_RippleBumpness ("_RippleBumpness"loat) = 1
		_AdditionalCubemapReflection ("_AdditionalCubemapReflection", Float) = 1
		_ReflectionColor ("_ReflectionColor", Color) = (1,1,1,1)
		_DiffuseColor ("_DiffuseColor", Color) = (1,1,1,1)
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 5155
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord6 : TEXCOORD6;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
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
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _BumpMap;
			sampler2D _BumpMapDetails;
			sampler2D _CameraDepthTexture;
			sampler2D _FoamTex;
			sampler2D _WaterForSSR_SavedG0;
			samplerCUBE _MyGlobalReflectionProbe;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
