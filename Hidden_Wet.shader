Shader "Hidden/Wet" {
	Properties {
		_Color ("Main Color", Color) = (0,0,0,0.5)
		_SpecColor ("Specular Color", Color) = (0,0,0,0.95)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 47178
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
