Shader "Hidden/Dof/DepthOfFieldHdr" {
	Properties {
		_MainTex ("-", 2D) = "black" {}
		_FgOverlap ("-", 2D) = "black" {}
		_LowRez ("-", 2D) = "black" {}
	}
	SubShader {
		Pass {
			ColorMask A
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 20163
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
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
