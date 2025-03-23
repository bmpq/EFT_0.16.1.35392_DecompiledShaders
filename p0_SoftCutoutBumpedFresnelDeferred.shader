Shader "p0/SoftCutoutBumpedFresnelDeferred" {
	Properties {
		[Queue] _Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		[NoScaleOffset] _SpecularMap ("Specular (RGB)", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap ("Normalmap", 2D) = "bump" {}
		_AddAlpha ("Add Alpha", Range(-1, 1)) = 0
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_DefVals ("Defuse Vals", Vector) = (0.1,2.5,0,0)
		_Smoothness ("Smoothness", Range(0, 1)) = 0
		_Specular ("Specular", Range(0, 1)) = 0
		_ReflectionStrength ("GI And Reflection Strength", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.3,0.3,0)
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
		
		void surf(Input IN, inout SurfaceOutputStandard og
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float2 texcoord4 : TEXCOORD4;
				float4 color : COLOR0;
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
			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _SpecularMap;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
