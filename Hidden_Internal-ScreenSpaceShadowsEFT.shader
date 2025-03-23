Shader "Hidden/Internal-ScreenSpaceShadowsEFT" {
	Properties {
		_ShadowMapTexture ("", any) = "" {}
		_ODSWorldTexture ("", 2D) = "" {}
		GlobalShadow ("", 2D) = "" {}
		GlobalShadowSampled ("", 2D) = "" {}
		GlobalShadowSampled2 ("", 2D) = "" {}
	}
	SubShader {
		Tags { "ShadowmapFilter" = "HardShadow" }
		Pass {
			Tags { "ShadowmapFilter" = "HardShadow" }
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 63610
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
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
