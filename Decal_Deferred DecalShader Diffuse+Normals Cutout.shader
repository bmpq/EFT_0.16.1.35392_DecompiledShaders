Shader "Decal/Deferred DecalShader Diffuse+Normals Cutout" {
	Properties {
		_MainTex ("Diffuse", 2D) = "white" {}
		_Color ("Main color", Color) = (1,1,1,1)
		_BumpMap ("Normals", 2D) = "bump" {}
		_NormalPower ("Normal power", Float) = 3
		_SpecularColor ("Specular color", Color) = (1,1,1,1)
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_SpecSmoothness ("Specular smoothness", Range(0, 1)) = 0
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Fog {
				Mode 0
			}
			GpuProgramID 19938
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 position : SV_POSITION0;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 normal : NORMAL0;
				float4 tangent : TANGENT0;
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
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
