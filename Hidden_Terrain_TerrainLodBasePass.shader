Shader "Hidden/Terrain/TerrainLodBasePass" {
	Properties {
		_Splat3 ("Layer 3 (A)", 2D) = "white" {}
		_Splat2 ("Layer 2 (B)", 2D) = "white" {}
		_Splat1 ("Layer 1 (G)", 2D) = "white" {}
		_Splat0 ("Layer 0 (R)", 2D) = "white" {}
		[Gamma] _Metallic0 ("Metallic 0", Range(0, 1)) = 0
		[Gamma] _Metallic1 ("Metallic 1", Range(0, 1)) = 0
		[Gamma] _Metallic2 ("Metallic 2", Range(0, 1)) = 0
		[Gamma] _Metallic3 ("Metallic 3", Range(0, 1)) = 0
		_Smoothness0 ("Smoothness 0", Range(0, 1)) = 1
		_Smoothness1 ("Smoothness 1", Range(0, 1)) = 1
		_Smoothness2 ("Smoothness 2", Range(0, 1)) = 1
		_Smoothness3 ("Smoothness 3", Range(0, 1)) = 1
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = 1;
		}
		ENDCG
	}
	Fallback "Nature/Terr
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 color : COLOR0;
				float4 texcoord5 : TEXCOORD5;
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
			sampler2D _Splat0;
			sampler2D _Splat1;
			sampler2D _Splat2;
			sampler2D _Splat3;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
