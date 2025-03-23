Shader "Hidden/HDRP/Sky/CloudLayer" {
	Properties {
	}
	SubShader {
		Pass {
			Blend 0 One OneMinusSrcAlpha, One OneMinusSrcAlpha
			Blend 1 DstColor Zero, DstColor Zero
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 41186
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
                float4 tmp0;
                //unsupported_bfi;
                tmp0.z = uint1(v.sv_vertexid.x) & uint1(0.0);
                o.position.xy = tmp0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                o.position.zw = float2(0.0, 1.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
