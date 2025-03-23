Shader "p0/SoftCutoutBumpedFresnel" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AddAlpha ("Add Alpha", Range(-1, 1)) = 0
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_DefVals ("Defuse Vals", Vector) = (0.1,2.5,0,0)
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.2,0.25,0)
	}
	SubShader {
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest+4" "RenderType" = "Transparent" }
		Pass {
			Name "DEFERRED"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest+4" "RenderType" = "Transparent" }
			GpuProgramID 5739
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
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
