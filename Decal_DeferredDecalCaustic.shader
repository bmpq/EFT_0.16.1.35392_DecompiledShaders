Shader "Decal/DeferredDecalCaustic" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("Stencil type to draw decals", Float) = 0
		_MainTex ("Caustics (RGB)", 2D) = "white" {}
		_Caustics1_ST ("Caustics 1 ST", Vector) = (0.8,0.8,0,0)
		_Caustics2_ST ("Caustics 2 ST", Vector) = (0.6,0.6,0,0)
		_Caustics3_ST ("Caustics 3 ST", Vector) = (0.8,0.8,0,0)
		_Caustics1_Speed ("Caustics 1 Speed", Vector) = (0.06,0.06,0,0)
		_Caustics2_Speed ("Caustics 2 Speed", Vector) = (-0.05,-0.04,0,0)
		_Caustics3_Speed ("Caustics 3 Speed", Vector) = (0,-0.03,0,0)
		_LayerCount ("Layers count", Range(2, 3)) = 2
		[Toggle(_COLOR_SPLIT_ON)] _ColorSplitEnabled ("Is color split enabled", Float) = 1
		_SplitRGB ("Color split amount", Float) = 0.125
		_SplitRGB_Multiplier ("Color split amount multiplier", Float) = 0.015
		_Color1 ("С1 color", Vector) = (1,1,1,1)
		_Color2 ("С2 color", Vector) = (1,1,1,1)
		_Color3 ("С3 color", Vector) = (1,1,1,1)
		_AlphaScale ("Alpha scale", Float) = 0.09
		_TimeScale ("T scale", Float) = 0.6
		_UVScale ("UV scale", Float) = 1.5
		_IntensityMultiplier ("Intensity Multiplier", Float) = 1.5
		_CausticsPower ("Caustics Contrast", Float) = 0.7
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.11,0.25,0)
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Front
			Stencil {
				ReadMask 3
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog {
				Mode 0
			}
			GpuProgramID 56638
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord : TEXCOORD0;
				float3 texcoord6 : TEXCOORD6;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord7 : TEXCOORD7;
				uint texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
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
