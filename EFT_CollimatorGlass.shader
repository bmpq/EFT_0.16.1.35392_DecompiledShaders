Shader "EFT/CollimatorGlass" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		_GlobalReflectionStrength ("_GlobalReflectionStrength", Float) = 0
		_Specular ("_Specular", Range(0.01, 5)) = 0.078125
		_FresPow ("_FresPow", Range(0.5, 6)) = 4
		_FresAdd ("_FresAdd", Range(0, 1)) = 0.3
	}
	SubShader {
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay+10" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Overlay+10" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 39052
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord5 : TEXCOORD5;
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
			samplerCUBE _Cube;
			samplerCUBE _MyGlobalReflectionProbe;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
