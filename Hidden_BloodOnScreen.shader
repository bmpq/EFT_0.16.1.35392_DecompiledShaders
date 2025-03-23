Shader "Hidden/BloodOnScreen" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BloodTex ("Blood (RGB)", 2D) = "white" {}
		_BloodColor ("Blood color (RGB)", Vector) = (0,0,0,0)
		_DudvMap ("DuDv map", 2D) = "black" {}
		_BloodTextureAmount ("Blood texture amount", Range(0, 1)) = 0
		_Refraction ("Refraction", Float) = 0
		_Blured ("Blured", 2D) = "white" {}
		_inputMin ("Input Black", Vector) = (0,0,0,1)
		_inputMax ("Input White", Vector) = (1,1,1,1)
		_inputGamma ("Input Gamma", Vector) = (1,1,1,1)
		_outputMin ("Output Black", Vector) = (0,0,0,1)
		_outputMax ("Output White", Vector) = (1,1,1,1)
		_BurnParam ("Burn parametr", Float) = 0.5
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
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
