Shader "Nature/SpeedTreeEFT" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_HueVariation ("Hue Variation", Vector) = (1,0.5,0,0.1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_DetailTex ("Detail", 2D) = "black" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.333
		[MaterialEnum(Off,0,Front,1,Back,2)] _Cull ("Cull", Float) = 2
		[MaterialEnum(None,0,Fastest,1,Fast,2,Better,3,Best,4,Palm,5)] _WindQuality ("Wind Quality", Range(0, 5)) = 0
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
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
	Fallback "Transparent/Cutout/Vertet frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _Color;
			// $Globals ConstantBuffers for Fragment Shader
			float _ThermalVisionOn;
			float4 _Temperature2;
			// Custom ConstantBuffers for Vertex Shader
			CBUFFER_START(SpeedTreeWind)
			CBUFFER_END
			CBUFFER_START(SpeedTreeWind_A)
			CBUFFER_END
			CBUFFER_START(SpeedTreeWind_B)
			CBUFFER_END
			CBUFFER_START(SpeedTreeWind_Calm)
			CBUFFER_END
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
