Shader "Hidden/WriteScreenAmbient" {
	Properties {
		_StencilType ("_StencilType", Float) = 1
		_AmbientBlur ("_AmbientBlur", Float) = 1
		_ReflectionIntensity ("_ReflectionIntensity", Float) = 1
	}
	SubShader {
		Pass {
			Blend Zero Zero, Zero Zero
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 32852
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
