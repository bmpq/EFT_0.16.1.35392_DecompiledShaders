Shader "Blood/BloodDrop" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Lifetime ("Lifetime", Range(0, 1)) = 1
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Transparent" }
		Pass {
			LOD 200
			Tags { "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 61924
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
                v2f o;
                o.texcoord.xy = v.texcoord.xy;
                o.sv_position = v.vertex;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
