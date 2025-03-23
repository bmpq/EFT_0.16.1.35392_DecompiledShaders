Shader "Hidden/TubeLight" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "Geometry-1" }
		Pass {
			Tags { "QUEUE" = "Geometry-1" }
			ColorMask 0
			ZTest Less
			ZWrite Off
			Cull Off
			Stencil {
				CompFront Always
				PassFront Keep
				FailFront Keep
				ZFailFront IncrementSaturate
				CompBack Always
				PassBack Keep
				FailBack Keep
				ZFailBack DecrementSaturate
			}
			GpuProgramID 61097
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
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
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
