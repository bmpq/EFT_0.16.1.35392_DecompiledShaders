Shader "Custom/OpticGlass" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Shininess ("Shininess", Range(0.01, 4)) = 0.078125
		_SpecPower ("Specular Power", Range(0.01, 10)) = 1
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_SpecTex ("Specular (R)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
		_FresPow ("_FresPow", Range(0.5, 6)) = 4
		_FresAdd ("_FresAdd", Range(0, 1)) = 0.3
		_SwitchToSightMultiplier ("_SwitchToSightMultiplier", Range(0, 1)) = 0.1
		_NormalHideness ("_NormalHideness", Float) = 6
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
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.A	CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float texcoord4 : TEXCOORD4;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord6 : TEXCOORD6;
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
			sampler2D _SpecTex;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
