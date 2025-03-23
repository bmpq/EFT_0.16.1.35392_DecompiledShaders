Shader "Hidden/AdvancedLightShadowMesh" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
			ColorMask 0
			ZTest Always
			ZWrite Off
			Cull Off
			Stencil {
				Ref 128
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 38400
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
                v2f o;
                o.position = v.vertex;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
		Pass {
			Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
			ColorMask 0
			ZTest Greater
			ZWrite Off
			Stencil {
				Comp Always
				Pass DecrementSaturate
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 78359
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
