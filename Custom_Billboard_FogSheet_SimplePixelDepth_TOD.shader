Shader "Custom/Billboard_FogSheet_SimplePixelDepth_TOD" {
	Properties {
		_MainTex ("Texture Image", 2D) = "white" {}
		_Color ("Tint", Vector) = (0,0,0,1)
		_TODSaturationAmount ("Time of day ambient color saturation", Range(0, 1)) = 1
		_TODColorClampMin ("Time of day ambient color clamp min", Range(0, 1)) = 0
		_TODColorClampMax ("Time of day ambient color clamp max", Range(0, 1)) = 1
		_TODColorTint ("Time of day ambient color tint", Vector) = (1,1,1,1)
		_DiffuseIntensity ("Opacity Intensity", Float) = 1.9
		_DistanceFadingAlphaMax ("Max Distance Alpha", Range(0, 3)) = 1
		_DistanceFadingAlphaMultiplier ("Distance Alpha Multiplier", Range(0, 5)) = 1
		_DistanceFadingAlphaStartOffset ("Start Offset of Distance Alpha", Range(-20, 0)) = -0.2
		_WorldPositionOffsetAmount ("World Position Offset UV Amount (0-1)", Range(0, 1)) = 1
		_DiffuseScale ("Diffuse UV Scale", Float) = 1
		_UVOffsetX ("UV Offset X", Float) = 1
		_UVOffsetY ("UV Offset Y", Float) = 1
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_ScrollXSpeed ("X Scroll Speed", Range(0, 100)) = 0.1
		_ScrollYSpeed ("Y Scroll Speed", Range(0, 100)) = 0.1
		_AngleFadeStrengthFront ("AngleFade Front Strength", Range(0, 10)) = 5
		_AngleFadeStrengthBack ("AngleFade Back Strength", Range(0, 10)) = 5
		_PixelFadeLength ("Pixel Depth Fade Length", Range(0, 50)) = 0.15
		_DiffusePower ("Diffuse Contrast", Range(0, 3)) = 1
		_NoiseForce ("Noise Power", Range(0, 500)) = 10
		_NoiseScale ("Noise Scale", Vector) = (10,10,0,0)
		_RadialPower ("Radial Contrast", Range(0, 10)) = 1
		_RadiusMultiplier ("Radius", Range(0, 25)) = 1
		_GradientPivot ("Position", Vector) = (0,0,0,0)
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
			o.Alpha =
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float4 texcoord : TEXCOORD0;
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
