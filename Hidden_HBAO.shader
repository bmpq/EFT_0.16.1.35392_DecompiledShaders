Shader "Hidden/HBAO" {
	Properties {
		_MainTex ("", 2D) = "" {}
		_HBAOTex ("", 2D) = "" {}
		_NoiseTex ("", 2D) = "" {}
		_DepthTex ("", 2D) = "" {}
		_NormalsTex ("", 2D) = "" {}
		_rt0Tex ("", 2D) = "" {}
		_rt3Tex ("", 2D) = "" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 16567
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 position : SV_POSITION0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			CBUFFER_START(FrequentlyUpdatedUniforms)
				float4x4 _WorldToCameraMatrix;
			CBUFFER_END
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _NoiseTex;
			sampler2D _CameraGBufferTexture2;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
