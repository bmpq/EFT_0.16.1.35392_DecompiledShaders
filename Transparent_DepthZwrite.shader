Shader "Transparent/DepthZwrite" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_SpecTex ("Specular (R), Gloss (A)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_SpecPower ("Specular Power", Range(0.01, 10)) = 1
		_Glossness ("Glossness", Range(0.01, 10)) = 1
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_GlobalReflectionStrength ("_GlobalReflectionStrength", Float) = 1
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
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
		
		void surf(Input IN, inout Surfa			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 color : COLOR0;
				float4 position : SV_POSITION0;
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
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
