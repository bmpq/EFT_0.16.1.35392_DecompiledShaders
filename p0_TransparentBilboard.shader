Shader "p0/TransparentBilboard" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_Distance ("1/Distance", Float) = 0.5
		_FogDencity ("FogDencity", Range(0.005, 0.3)) = 0.1
		_BlinkSpeed ("Blink Speed", Float) = 2
		_BlinkMinAlpha ("Blink Min Alpha", Float) = 0.2
		_LightMultyplier ("Light Multyplier", Range(0, 1)) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstMode ("DstMode", Float) = 10
	}
	SubShader {
		Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
		Pass {
			Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
			Blend Zero Zero, Zero Zero
			ZWrite Off
			Cull Off
			GpuProgramID 38483
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 color : COLOR0;
				float4 texcoord1 : TEXCOORD1;
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
