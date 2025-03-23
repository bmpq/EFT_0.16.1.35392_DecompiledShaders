Shader "CW FX/OpticSight" {
	Properties {
		_MarkTex ("Mark Texture", 2D) = "black" {}
		_MaskTex ("Mask Texture(A)", 2D) = "white" {}
		_MaskTex2 ("Mask Texture2(A)", 2D) = "white" {}
		_MarkLightness ("Mark Lightness", Range(0, 0.1)) = 0.015
		_ShiftDirection ("_ShiftDirection", Vector) = (0,0,1,0)
		_Shifts ("_Shifts", Vector) = (0,0,0,0)
		_Scales ("_Scales", Vector) = (100,100,100,100)
		_NormalHideness ("_NormalHideness", Range(1, 256)) = 6
	}
	SubShader {
		Tags { "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent+100" }
		Pass {
			Tags { "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent+100" }
			ColorMask 0
			ZTest Always
			ZWrite Off
			Stencil {
				Comp Always
				Pass Zero
				Fail Zero
				ZFail Keep
			}
			GpuProgramID 28027
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
                o.sv_position.xy = v.vertex.zx * float2(1000.0, 1000.0);
                o.sv_position.zw = float2(0.1, 1.0);
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
			Tags { "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent+100" }
			ColorMask A
			ZWrite Off
			Stencil {
				Ref 1
				WriteMask 1
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 77098
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
