Shader "GPUInstancer/Foliage_Simple" {
	Properties {
		_Cutoff ("Mask Clip Value", Float) = 0.33
		_CutoffFade ("Cutoff Fade[start distance, end, start shadow, end shadow]", Vector) = (40,45,45,50)
		_WindWaveNormalTexture ("Wind Wave Normal Texture", 2D) = "bump" {}
		_DryColor ("Dry Color", Vector) = (1,0,0,0)
		_HealthyColor ("Healthy Color", Vector) = (0,1,0.2137935,0)
		_MainTexArray ("_MainTexArray", 2DArray) = "" {}
		_NormalMapArray ("_NormalMapArray", 2DArray) = "" {}
		_AmbientOcclusion ("Ambient Occlusion", Range(0, 1)) = 0.5
		_NoiseSpread ("Noise Spread", Float) = 0.1
		_NormalMap ("Normal Map", 2D) = "bump" {}
		_WindWaveTintColor ("Wind Wave Tint Color", Vector) = (0.07586241,0,1,0)
		_HealthyDryNoiseTexture ("Healthy Dry Noise Texture", 2D) = "white" {}
		[Toggle] _WindWavesOn ("Wind Waves On", Float) = 0
		[Toggle(IsBillboard)] IsBillboard ("IsBillboard", Float) = 0
		_WindWaveTint ("Wind Wave Tint", Range(0, 1)) = 0.5
		_WindWaveSway ("Wind Wave Sway", Range(0, 1)) = 0.15
		_WindIdleSway ("W Idle Sway", Range(0, 1)) = 0.3
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
		[HideInInspector] _TaaBias ("", Float) = -1.5
		[PerRendererData] _WaveAndDistance ("Wave and distance", Vector) = (12,3.6,1,1)
		_ZWrite ("_ZWrite", Float) = 1
		_ZTest ("_ZTest", Float) = 2
		_ArrayIndex ("_ArrayIndex", Float) = 0
		[Toggle(AditionClip_ON)] AditionClip ("AditionClip for editor", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "AlphaTest-351" "RenderType" = "GPUIFoliage" }
		Pass {
			Name "DepthPrePass"
			Tags { "LIGHTMODE" = "MOTIONVECTORS" }
			ColorMask 0
			ZTest Less
			Cull Off
			GpuProgramID 4823
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float color : COLOR0;
				float color1 : COLOR1;
				uint sv_instanceid : SV_InstanceID0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			int _ArrayIndex;
			// $Globals ConstantBuffers for Fragment Shader
			float _MipMapChecker;
			// Custom ConstantBuffers for Vertex Shader
			CBUFFER_START(Wind_InstanceRegular)
			CBUFFER_END
			CBUFFER_START(EachFrameUpdate)
			CBUFFER_END
			CBUFFER_START(Const)
			CBUFFER_END
			// Custom ConstantBuffers for Fragment Shader
			CBUFFER_START(RareUpdate)
			CBUFFER_END
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
