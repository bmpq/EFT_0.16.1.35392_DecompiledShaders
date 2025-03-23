Shader "Custom/Eye Burn" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Rotation ("_Rotation", Float) = 0
		_Coef ("_Coef", Float) = 1
		[HideInInspector] _RampTex ("RampTex", 2D) = "grayscaleRamp" {}
	}
	SubShader {
		LOD 200
		Pass {
			LOD 200
			Blend One One, One One
			BlendOp Max, Max
			ZWrite Off
			GpuProgramID 9212
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float2 texcoord : TEXCOORD0;
				float4 sv_position : SV_Position0;
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
