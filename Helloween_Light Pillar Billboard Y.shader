Shader "Helloween/Light Pillar Billboard Y" {
	Properties {
		_MainTex ("(R) Base, (G) Noise, (B) Alpha", 2D) = "white" {}
		[HDR] _Color ("Color", Vector) = (1,1,1,1)
		_Alpha ("Alpha", Range(0, 1)) = 1
		_Intensity ("Intensity", Range(0, 1.5)) = 1
		_IntensityFlickerSpeed ("Intensity Flicker Speed", Range(0, 5)) = 1
		[Space] _HeightTopYFade ("Height Top Y Fade", Range(0, 1)) = 0
		_DistanceFade ("Distance Fade", Range(0, 1)) = 0
		[Space] [Toggle(ENABLE_NOISE)] _EnableNoise ("Enable Noise", Float) = 0
		_NoiseSpeed ("Noise Speed (XY)", Vector) = (0,-0.1,0,0)
		_NoiseIntensity ("Noise Intensity", Range(0, 1)) = 0.05
		[Space] _Temperature ("Temperature", Vector) = (0.1,0.27,0.4,0)
		_ThermalPower ("Thermal Power", Float) = 1
		[Space] _InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
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
			float2 uv_MainOne, SrcAlpha One
			ZWrite Off
			Cull Front
			GpuProgramID 11223
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 color : COLOR0;
				float2 texcoord : TEXCOORD0;
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
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
