Shader "Hidden/Tree Billboard LOD" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,0)
		_HueVariation ("Hue Variation", Color) = (1,0.5,0,0.1)
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Cutoff ("_Cutoff", Float) = 0.5
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		LOD 100
		Tags { "QUEUE" = "AlphaTest+10" "RenderType" = "Opaque" }
		Pass {
			Name "DEFERRED"
			LOD 100
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest+10" "RenderType" = "Opaque" }
			GpuProgramID 34815
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 sv_position : SV_Position0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
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
