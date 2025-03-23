Shader "Hidden/FrostbiteEffect" {
	Properties {
		[HideInInspector] _MainTex ("Base Map (RGB)", 2D) = "white" {}
		_BaseColor ("BaseColor", Color) = (0.1607843,0.282353,0.4352941,0.3490196)
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "bump" {}
		_Tiling ("Tiling", Vector) = (1,1,0,0)
		_ODRF ("Opac, Distor, Radius, Falloff", Vector) = (0.75,0.15,0.325,1.5)
		_ShapeRadius ("ShapeRadius", Vector) = (1,1,0,0)
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 1228
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
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
