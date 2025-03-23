Shader "Hidden/ColorBlend" {
	Properties {
		_SrcFactor ("_SrcFactor", Float) = 0
		_DstFactor ("_DstFactor", Float) = 0
		_Operation ("_Operation", Float) = 0
	}
	SubShader {
		Pass {
			Blend Zero Zero, Zero Zero
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode 0
			}
			GpuProgramID 12625
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
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
                v2f o;
                o.sv_position = v.vertex;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
