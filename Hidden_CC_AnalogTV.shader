Shader "Hidden/CC_AnalogTV" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Phase ("Phase (time)", Float) = 0.01
		_NoiseIntensity ("Static noise intensity", Float) = 0.5
		_ScanlinesIntensity ("Scanlines intensity", Float) = 2
		_ScanlinesCount ("Scanlines count", Float) = 1024
		_ScanlinesOffset ("Scanlines vertical offset", Float) = 0
		_Distortion ("Distortion", Float) = 0.2
		_CubicDistortion ("Cubic Distortion", Float) = 0.6
		_Scale ("Scale (Zoom)", Float) = 0.8
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 31502
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
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
