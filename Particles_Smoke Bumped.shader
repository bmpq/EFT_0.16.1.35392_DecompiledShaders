Shader "Particles/Smoke Bumped" {
	Properties {
		[Header(Vertex Color (R)smoke lightness   (G)flame intensity  (B)distortion   (A)alpha )] [Queue] _Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		[HDR] _FireColor ("Fire Color", Vector) = (1,0.5,0,1)
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
		_NearCameraFade ("_NearCameraFade", Range(0.01, 3)) = 1
		_GIIndirect ("GI Indirect", Range(0, 1)) = 1
		_Scaterring ("Scaterring", Range(0, 1)) = 0.5
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_AnimationSpeed ("Animation Speed", Float) = 1
		_Distortion ("Distortion", Range(0, 1)) = 1
		_NoiseScale ("Noise Scale", Float) = 1
		_Distortion ("Distortion", Range(0, 1)) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, ia
			ColorMask RGB
			ZWrite Off
			GpuProgramID 19920
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float4 color : COLOR0;
				float4 texcoord4 : TEXCOORD4;
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
			sampler2D _NoiseTex;
			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _CameraDepthTexture;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
