Shader "Hidden/CloudsShadow" {
	Properties {
		_MapLow ("_MapLow", 2D) = "white" {}
		_MapHigh ("_MapHigh", 2D) = "white" {}
		_Noise ("_Noise", 2D) = "white" {}
		[Space(32)] _CloudRoughnessMin ("_RoughnessMin", Range(0, 1)) = 1
		_CloudNoiseMapRoughness ("_NoiseMapRoughness", Range(0, 1)) = 1
		_CloudDensity ("_Density", Range(-1, 1)) = 1
		_CloudCurviness ("_Curviness", Float) = 1
		_CloudScale ("_Scale", Float) = 1
		_CloudPosition ("_CloudPosition", Vector) = (0,0,0,0)
		_ShadowStrength ("_ShadowStrength", Range(0, 1)) = 1
	}
	SubShader {
		Pass {
			Blend DstColor Zero, DstColor Zero
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 13255
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
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
