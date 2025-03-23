Shader "Nature/SpeedTree Billboard Replaced" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_HueVariation ("Hue Variation", Color) = (1,0.5,0,0.1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		[MaterialEnum(None,0,Fastest,1)] _WindQuality ("Wind Quality", Range(0, 1)) = 0
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0,0.1,0.1,0)
	}
	SubShader {
		LOD 400
		Tags { "DisableBatching" = "LodFading" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "DisableBatching" = "LodFading" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			GpuProgramID 40069
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float _BilboardTreesWindPower;
			float4 _Color;
			// $Globals ConstantBuffers for Fragment Shader
			float _ThermalVisionOn;
			float4 _Temperature;
			// Custom ConstantBuffers for Vertex Shader
			CBUFFER_START(SpeedTreeWind)
			CBUFFER_END
			CBUFFER_START(UnityBillboardPerCamera)
				float3 unity_BillboardNormal;
				float3 unity_BillboardTangent;
			CBUFFER_END
			CBUFFER_START(UnityBillboardPerBatch)
			CBUFFER_END
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
