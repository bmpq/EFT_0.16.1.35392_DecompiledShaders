Shader "Hidden/GPUInstancer/Nature/TreeProxy" {
	Properties {
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Cull Off
			GpuProgramID 48293
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
			};
			struct fout
			{
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
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                if (NaN) {
                    discard;
                }
                return o;
			}
			ENDCG
		}
	}
}