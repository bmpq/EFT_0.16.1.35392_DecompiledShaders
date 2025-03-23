Shader "Custom/Matcap" {
	Properties {
		[Header(Base Properties)] [Space] _Color ("Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _MainTex ("Matcap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("Normal Map", 2D) = "bump" {}
		_NormalPower ("Normal Power", Range(0.1, 8)) = 1
		_Rotation ("Rotation", Range(-180, 180)) = 0
		_Scale ("Scale", Range(0.1, 2)) = 1
		_OffsetX ("Offset X", Range(-5, 5)) = 0
		_OffsetY ("Offset Y", Range(-5, 5)) = 0
		[Header(Attenuation Properties)] [Space] _AttenuationAmount ("Amount", Float) = 0.45
		_AttenuationRange ("Range", Float) = 0.3
		_AttenuationSoftness ("Softness", Float) = 0.35
		[Header(HSBC Properties)] [Space] _Hue ("Hue", Range(0, 1)) = 0
		_Saturation ("Saturation", Range(0, 1)) = 0.5
		_Brightness ("Brightness", Range(0, 1)) = 0.5
		_Contrast ("Contrast", Range(0, 1)) = 0.5
		_ViewDirOffset ("ViewDirOffset", Vector) = (0,0,0,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma te" "SHADOWSUPPORT" = "true" }
			GpuProgramID 1219
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
				float3 texcoord4 : TEXCOORD4;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _Contrast;
			float4 _Color;
			float4 _ViewDirOffset;
			float _OffsetX;
			float _OffsetY;
			float _NormalPower;
			float _Rotation;
			float _Scale;
			float _Hue;
			float _Saturation;
			float _Brightness;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _NormalMap;
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
