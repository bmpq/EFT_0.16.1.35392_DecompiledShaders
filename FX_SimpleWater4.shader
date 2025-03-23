Shader "FX/SimpleWater4" {
	Properties {
		_ReflectionTex ("Internal reflection", 2D) = "white" {}
		_MainTex ("Fallback texture", 2D) = "black" {}
		_BumpMap ("Normals ", 2D) = "bump" {}
		_DistortParams ("Distortions (Bump waves, Reflection, Fresnel power, Fresnel bias)", Vector) = (1,1,2,1.15)
		_InvFadeParemeter ("Auto blend parameter (Edge, Shore, Distance scale)", Vector) = (0.15,0.15,0.5,1)
		_AnimationTiling ("Animation Tiling (Displacement)", Vector) = (2.2,2.2,-1.1,-1.1)
		_AnimationDirection ("Animation Direction (displacement)", Vector) = (1,1,1,1)
		_BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
		_BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
		_FresnelScale ("FresnelScale", Range(0.15, 4)) = 0.75
		_BaseColor ("Base color", Vector) = (0.54,0.95,0.99,0.5)
		_ReflectionColor ("Reflection color", Vector) = (0.54,0.95,0.99,0.5)
		_SpecularColor ("Specular color", Vector) = (0.72,0.72,0.72,1)
		_WorldLightDir ("Specular light direction", Vector) = (0,0.1,-0.5,0)
		_Shininess ("Shinss", Range(2, 500)) = 200
		_GerstnerIntensity ("Per vertex displacement", Float) = 1
		_GAmplitude ("Wave Amplitude", Vector) = (0.3,0.35,0.25,0.25)
		_GFrequency ("Wave Frequency", Vector) = (1.3,1.35,1.25,1.25)
		_GSteepness ("Wave Steepness", Vector) = (1,1,1,1)
		_GSpeed ("Wave Speed", Vector) = (1.2,1.375,1.1,1.5)
		_GDirectionAB ("Wave Direction", Vector) = (0.3,0.85,0.85,0.25)
		_GDirectionCD ("Wave Direction", Vector) = (0.1,0.9,0.5,0.5)
	}
	SubShader {
		LOD 500
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		GrabPass {
			"_RefractionTex"
		}
		Pass {
			LOD 500
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Cull Off
			GpuProgramID 64062
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float texcoord5 : TEXCOORD5;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float4 _InvFadeParemeter;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _ScatteringTex;
			sampler2D _RefractionTex;
			sampler2D _CameraDepthTexture;
			sampler2D _ReflectionTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
