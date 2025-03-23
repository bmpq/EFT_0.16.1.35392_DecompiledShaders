Shader "Hidden/InfectionEffectShader" {
	Properties {
		[HideInInspector] _MainTex ("Texture", 2D) = "white" {}
		_DistortMap ("Distort Map", 2D) = "white" {}
		_VeinsPower ("Veins Power", Range(0, 100)) = 17
		_VeinsZoom ("Veins Zoom", Range(-10, 10)) = 0.75
		_MaskArea ("Mask Area", Vector) = (0.25,650,1,1)
		_ColorA ("Color A", Vector) = (0,0,0,0)
		_ColorB ("Color B", Vector) = (0,0,0,0)
		_Animation ("Animation", Vector) = (45,-0.9,1.35,0.02)
		_Animation2 ("Animation 2", Vector) = (0.23,1,0,0)
		_ColorANoiseTex ("Color A Noise Texture", 2D) = "white" {}
		_NoiseScale ("Noise Scale", Range(0, 1)) = 0.001
		_NoiseSpeed ("Noise Speed", Range(-16, 16)) = 0.001
		_RefractScale ("Refract Scale", Range(0, 16)) = 0.001
		_RefractPower ("Refract Power", Range(0, 16)) = 0.005
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

		void surf(Input IN, ino		float4 position : SV_POSITION0;
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
