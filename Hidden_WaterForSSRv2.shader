Shader "Hidden/WaterForSSRv2" {
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
		_RippleBumpness ("_RippleBumpnes Float) = 1
		_AdditionalCubemapReflection ("_AdditionalCubemapReflection", Float) = 1
		_ReflectionColor ("_ReflectionColor", Color) = (1,1,1,1)
		_DiffuseColor ("_DiffuseColor", Color) = (1,1,1,1)
	}
	SubShader {
		Pass {
			Blend 0 SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			Blend 1 SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			Blend 2 SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			Blend 3 SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 36930
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
				float sv_target4 : SV_Target4;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _ThermalVisionOn;
			float3 TOD_SunDirection;
			float3 TOD_SunLightColor;
			float2 _FresnelVals;
			float3 _FoamColor;
			float3 _FoamVals;
			float3 _DepthColorShallow;
			float3 _DepthColorDeep;
			float4 _ValsNormA;
			float4 _ValsNormB;
			float4 _ValsNormD;
			float4 _ValsFoamA;
			float4 _ValsFoamB;
			float SSRenabled;
			float4 _DepthVals;
			float2 _BorderFadeDistVals;
			float _Bumpiness;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _BumpMap;
			sampler2D _BumpMapDetails;
			sampler2D _CameraDepthTexture;
			sampler2D _FoamTex;
			sampler2D _WaterForSSR_SavedG0;
			sampler2D _WaterForSSR_SavedG2;
			samplerCUBE _MyGlobalReflectionProbe;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
