Shader "Hidden/PrismKinoObscurance" {
	Properties {
		_MainTex ("", 2D) = "" {}
		_AOTex ("", 2D) = "" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 62507
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
			int _AOSampleCount;
			float _AOIntensity;
			float _AORadius;
			float _AOBias;
			float _AOTargetScale;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthNormalsTexture;
			sampler2D _SSAOMask;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
