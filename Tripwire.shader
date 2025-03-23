Shader "Tripwire" {
	Properties {
		[Space] _Scale ("Scale", Range(0, 0.02)) = 0.01
		_MinMaxDistance ("Min Max Distance", Vector) = (5,10,0,0)
		[Space] _Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
		[Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		_HeatVisible ("_HeatVisible([0-1] for thermalVision only)", Float) = 1
		[HDR] _HeatColor1 ("_HeatColor1", Vector) = (1,0,0,1)
		[HDR] _HeatColor2 ("_HeatColor2", Vector) = (1,0.34,0,1)
		_HeatCenter ("_HeatCenter", Vector) = (0,0,0,1)
		_HeatSize ("_HeatSize", Vector) = (0.02,0.04,0.02,1HeatTemp ("_HeatTemp", Float) = 0
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 54178
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
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
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
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
