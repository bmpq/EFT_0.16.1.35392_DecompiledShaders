Shader "Custom/ShitOnScreen" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_ShitTex ("Shit (RGB)", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_VisibilityCheckerSize ("Visibility Checker Size", Float) = 0.01
		_Intensity ("Intensity", Float) = 0.6
		_NoiseIntensity ("NoiseIntensity", Float) = 0.6
		_NoiseScale ("NoiseScale", Vector) = (1,1,1,1)
		_FallofShift ("Fallof Shift", Float) = 0.5
		_FallofStrength ("Fallof Strength", Float) = 32
		_DepthOffset ("DepthOffset", Float) = 0.2
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 49129
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
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
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0.x = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[0];
                tmp0.y = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[0];
                tmp0.z = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[0];
                tmp1.x = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[0];
                tmp1.y = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[1];
                tmp1.z = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[1];
                tmp1.w = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[1];
                tmp2.x = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[1];
                tmp2.y = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[2];
                tmp3.x = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[2];
                tmp3.y = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[2];
                tmp3.z = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[2];
                tmp3.w = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[3];
                tmp4.x = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[3];
                tmp4.y = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[3];
                tmp4.z = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[3];
                tmp4.w = ((float4[1])rsc0.xxxx.Load(v.sv_vertexid.x))[4];
                //unsupported_nop;
                tmp1 = tmp1;
                tmp3 = tmp3;
                tmp4 = tmp4;
                tmp0.xyz = tmp0.xyz;
                tmp2.xy = tmp2.xy;
                tmp0.w = floor(0.0);
                tmp0.xyz = tmp0.xyz;
                tmp3 = tmp3;
                tmp1 = tmp1;
                tmp2.xy = tmp2.xy;
                tmp4 = tmp4;
                tmp0 = tmp0;
                tmp4 = tmp4;
                tmp1 = tmp1;
                tmp3 = tmp3;
                tmp2.xy = tmp2.xy;
                o.position = tmp0;
                o.texcoord = tmp4;
                o.texcoord1 = tmp1;
                o.texcoord3 = tmp3;
                o.texcoord2.xy = tmp2.xy;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
