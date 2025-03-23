Shader "p0/Reflective/Specular" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("_StencilType", Float) = 0
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_SpecPower ("Specular Power", Range(0.01, 10)) = 1
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.5,0.6,0)
		[Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		_HeatVisible ("_HeatVisible([0-1] for thermalVision)", Float) = 1
		[HDR] _HeatColor1 ("_HeatColor1", Vector) = (1,0,0,1)
		[HDR] _HeatColor2 ("_HeatColor2", Vector) = (1,0.34,0,1)
		_HeatCenter ("_HeatCenter", Vector) = (0,0,0,1)
		_HeatSize ("_HeatSize", Vector) 02,0.04,0.02,1)
		_HeatTemp ("_HeatTemp", Float) = 0
	}
	SubShader {
		LOD 300
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 44322
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
			sampler2D _MainTex;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
