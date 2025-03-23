Shader "Custom/LocalDustParticlesLighted" {
	Properties {
		_ParticleTex ("_ParticleTex", 3D) = "" {}
		_Focus ("_Focus", Float) = 0.4
		_FocusSize ("_FocusSize", Float) = 0.6
		_HideDist ("_HideDist", Float) = 10
		_HideFade ("_HideFade", Float) = 4
	}
	SubShader {
		Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			Lighting On
			GpuProgramID 32668
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float4 color : COLOR0;
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
