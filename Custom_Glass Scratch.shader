Shader "Custom/Glass Scratch" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Rotation ("Ratation", Float) = 0
	}
	SubShader {
		LOD 200
		Pass {
			LOD 200
			Blend One One, One One
			ZWrite Off
			GpuProgramID 65471
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
