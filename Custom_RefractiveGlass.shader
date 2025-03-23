Shader "Custom/RefractiveGlass" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		[NoScaleOffset] _TransparentTex ("Transparent (R)", 2D) = "white" {}
		[NoScaleOffset] _Cube ("Reflection Cubemap", Cube) = "" {}
		[NoScaleOffset] [Normal] _BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Specular ("_Specular", Range(0.01, 5)) = 0.078125
		_Glossness ("_Glossness", Range(0.01, 5)) = 0.078125
		_BumpAmt ("Distortion", Range(0, 128)) = 10
		_GlobalReflectionStrength ("_GlobalReflectionStrength", Float) = 1
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
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
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			GpuProgramID 39322
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
				float4 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float TOD_Brightness;
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
