Shader "Custom/Vert Paint Standard" {
	Properties {
		_BlendStrength ("Blend Strength", Range(0.1, 30)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex0 ("Base (RGB) Smoothness (A) 0", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap0 ("Normalmap 0", 2D) = "bump" {}
		[Gamma] _Metallic0 ("Metallic 0", Range(0, 1)) = 0
		_Smoothness0 ("Smoothness 0", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex1 ("Base (RGB) Smoothness (A) 1", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap1 ("Normalmap 1", 2D) = "bump" {}
		[Gamma] _Metallic1 ("Metallic 1", Range(0, 1)) = 0
		_Smoothness1 ("Smoothness 1", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex2 ("Base (RGB) Smoothness (A) 2", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap2 ("Normalmap 2", 2D) = "bump" {}
		[Gamma] _Metallic2 ("Metallic 2", Range(0, 1)) = 0
		_Smoothness2 ("Smoothness 2", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] [NoScaleOffset] _Heights ("Heights", 2D) = "white" {}
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
			GpuProgramID 64234
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 color : COLOR0;
				float4 texcoord7 : TEXCOORD7;
				float4 texcoord8 : TEXCOORD8;
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
			sampler2D _Heights;
			sampler2D _MainTex0;
			sampler2D _MainTex1;
			sampler2D _MainTex2;
			sampler2D _BumpMap0;
			sampler2D _BumpMap1;
			sampler2D _BumpMap2;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
