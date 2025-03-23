Shader "Hidden/MaskTexture" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("_MainTex", 2D) = "white" {}
		_Mask ("_MainTex", 2D) = "white" {}
		_InvMaskSize ("_InvMaskSize", Float) = 1
		_InvAspect ("_InvAspect", Float) = 1
		_CameraAspect ("_CameraAspect", Float) = 1
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 42195
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
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
