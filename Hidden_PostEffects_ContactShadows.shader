Shader "Hidden/PostEffects/ContactShadows" {
	Properties {
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 5774
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float2 texcoord : TEXCOORD0;
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
                tmp0.x = v.sv_vertexid.x != 1;
                o.texcoord.x = tmp0.x ? 0.0 : 2.0;
                o.position.x = tmp0.x ? -1.0 : 3.0;
                tmp0.x = v.sv_vertexid.x == 2;
                o.texcoord.y = tmp0.x ? 2.0 : 0.0;
                o.position.y = tmp0.x ? -3.0 : 1.0;
                o.position.zw = float2(1.0, 1.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
