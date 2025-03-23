Shader "Decal/Deferred DecalShader Diffuse+Normals Dynamic" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("Stencil type to draw decals", Float) = 0
		_MainTex ("Diffuse", 2D) = "white" {}
		_Color ("Main color", Color) = (1,1,1,1)
		_BumpMap ("Normals", 2D) = "bump" {}
		_NormalPower ("Normal power", Float) = 3
		_SpecularColor ("Specular color", Color) = (1,1,1,1)
		_SpecSmoothness ("Specular smoothness", Range(0, 1)) = 0
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.13,0.33,0)
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Stencil {
				ReadMask 3
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog {
				Mode 0
			}
			GpuProgramID 52388
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float2 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord6 : TEXCOORD6;
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
			float _NormalPower;
			float4 _Color;
			float4 _SpecularColor;
			float4 _UvStartEnd;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
