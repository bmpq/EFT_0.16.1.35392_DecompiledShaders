Shader "Hidden/ThermalVision" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RampTex ("Ramp Tex", 2D) = "white" {}
		_Noise ("_Noise", 2D) = "white" {}
		_NoiseScale ("_NoiseScale", Vector) = (1,1,1,1)
		_NoiseIntensity ("_NoiseIntensity", Float) = 1
		_MainTexColorCoef ("_MainTex Color Coef", Range(0.01, 10)) = 1
		_MinimumTemperatureValue ("Minimum Temperature Value", Range(0.01, 10)) = 1
		_DepthFade ("Depth Fade", Float) = 1
		_BlurTex ("Blur Tex", 2D) = "white" {}
		_RadiusBlur ("_RadiusBlur", Float) = 7
		_Bias ("_Bias", Float) = 1.6
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
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "Hidden/Intffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
