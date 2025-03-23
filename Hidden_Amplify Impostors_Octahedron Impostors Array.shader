Shader "Hidden/Amplify Impostors/Octahedron Impostors Array" {
	Properties {
		[NoScaleOffset] _AlbedoArray ("Albedo & Alpha array", 2DArray) = "" {}
		[NoScaleOffset] _NormalsArray ("Normals & Depth array", 2DArray) = "" {}
		[NoScaleOffset] _Specular ("Specular & Smoothness", 2D) = "black" {}
		[NoScaleOffset] _Emission ("Emission & Occlusion", 2D) = "black" {}
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "AlphaTest+8" "RenderType" = "Opaque" }
		Pass {
			Name "Deferred"
			Tags { "DisableBatching" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest+8" "RenderType" = "Opaque" }
			Stencil {
				Ref 192
				WriteMask 207
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 14117
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
				uint texcoord6 : TEXCOORD6;
				uint texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
				float oDepth : SV_Depth0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D unity_DitherMask;
			sampler2D _Emission;
			sampler2D _Specular;
			UNITY_DECLARE_TEX2DARRAY(_AlbedoArray);
			UNITY_DECLARE_TEX2DARRAY(_NormalsArray);
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
