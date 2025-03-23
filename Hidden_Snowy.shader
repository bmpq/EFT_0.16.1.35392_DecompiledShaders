Shader "Hidden/Snowy" {
	Properties {
		_SnowDepthBias ("Snow Depth Bias", Float) = 3E-05
		_Color ("Main Color", Color) = (0,0,0,0.5)
		_SpecColor ("Specular Color", Color) = (0,0,0,0.95)
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
		_NightVisionFactor ("_NightVisionFactor", Vector) = (0.8,0.8,0.8,0)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero One
			Blend 1 SrcAlpha OneMinusSrcAlpha, One Zero
			ZTest Always
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 3
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 12341
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
				float sv_target4 : SV_Target4;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float3 _SpringSnowFactor;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
