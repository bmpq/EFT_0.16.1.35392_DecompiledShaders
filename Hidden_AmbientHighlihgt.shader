Shader "Hidden/AmbientHighlihgt" {
	Properties {
		_StencilType ("_StencilType", Float) = 1
		_AmbientBlur ("_AmbientBlur", Float) = 1
		_SHAr ("_SHAr", Vector) = (0,0,0,0)
		_SHAr ("_SHAr", Vector) = (0,0,0,0)
		_SHAg ("_SHAg", Vector) = (0,0,0,0)
		_SHAb ("_SHAb", Vector) = (0,0,0,0)
		_SHBr ("_SHBr", Vector) = (0,0,0,0)
		_SHBg ("_SHBg", Vector) = (0,0,0,0)
		_SHBb ("_SHBb", Vector) = (0,0,0,0)
		_SHC ("_SHC", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
			Blend Zero Zero, Zero Zero
			ZTest Always
			ZWrite Off
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
			GpuProgramID 19844
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
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
