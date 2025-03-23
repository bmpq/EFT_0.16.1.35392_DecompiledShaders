Shader "Hidden/Amplify Impostors/Octahedron Impostor" {
	Properties {
		[NoScaleOffset] _Albedo ("Albedo & Alpha", 2D) = "white" {}
		[NoScaleOffset] _Normals ("Normals & Depth", 2D) = "white" {}
		[NoScaleOffset] _Specular ("Specular & Smoothness", 2D) = "black" {}
		[NoScaleOffset] _Emission ("Emission & Occlusion", 2D) = "black" {}
		[HideInInspector] _Frames ("Frames", Float) = 16
		[HideInInspector] _ImpostorSize ("Impostor Size", Float) = 1
		[HideInInspector] _Offset ("Offset", Vector) = (0,0,0,0)
		[HideInInspector] _AI_SizeOffset ("Size & Offset", Vector) = (0,0,0,0)
		_TextureBias ("Texture Bias", Float) = -1
		_Parallax ("Parallax", Range(-1, 1)) = 1
		[HideInInspector] _DepthSize ("DepthSize", Float) = 1
		_ClipMask ("Clip", Range(0, 1)) = 0.33
		_AI_ShadowBias ("Shadow Bias", Range(0, 2)) = 0.25
		_AI_ShadowView ("Shadow View", Range(0, 1)) = 1
		[Toggle(_HEMI_ON)] _Hemi ("Hemi", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma s {
			Name "Deferred"
			Tags { "DisableBatching" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest+8" "RenderType" = "Opaque" }
			GpuProgramID 33446
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
				float oDepth : SV_Depth0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _Normals;
			sampler2D _Albedo;
			sampler2D _Emission;
			sampler2D _Specular;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
