Shader "Custom/TracerSmoke2" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_NoiseScale ("_NoiseScale", Float) = 1
		_TracerPeriod ("_TracerPeriod", Float) = 1
		_VanishSpeed ("_VanishSpeed", Float) = 1
		_SizeMin ("_SizeMin", Float) = 1
		_SizeMax ("_SizeMax", Float) = 1
		_ViewDirCosAlpha ("_ViewDirCosAlpha", Range(0, 1)) = 0
		_AnimationSpeed ("Animation Speed", Float) = 1
		_DistortionMin ("_DistortionMin", Range(0, 1)) = 0.2
		_DistortionMax ("_DistortionMax", Range(0, 1)) = 0.8
		_FadeIn ("_FadeIn", Float) = 0.2
		_FadeOut ("_FadeOut", Float) = 0.2
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
			o.	float2 texcoord : TEXCOORD0;
				float2 texcoord2 : TEXCOORD2;
				float4 texcoord1 : TEXCOORD1;
				float4 color : COLOR0;
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
