Shader "Hidden/CameraMotionBlur" {
	Properties {
		_MainTex ("-", 2D) = "" {}
		_NoiseTex ("-", 2D) = "grey" {}
		_VelTex ("-", 2D) = "black" {}
		_NeighbourMaxTex ("-", 2D) = "black" {}
	}
	SubShader {
		Pass {
			ZTest Always
			Cull Off
			GpuProgramID 27299
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
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
