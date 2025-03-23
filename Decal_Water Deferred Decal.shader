Shader "Decal/Water Deferred Decal" {
	Properties {
		[Header(Vertex Paint (A))] [Queue] _Color ("Main Color", Vector) = (0,0,0,0.5)
		_SpecColor ("Specular Color", Vector) = (0,0,0,0.95)
		_Smoothness ("Smoothness", Range(0, 1)) = 1
		_EmissionColor ("Emission", Vector) = (0,0,0,0)
		_MainTex ("Mask (R)", 2D) = "white" {}
		_FadeStrength ("Fade Strength", Float) = 2
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_ReflectionStrength ("GI And Reflection Strength", Float) = 1
		_Fresnel ("Fresnel", Range(0, 1)) = 0.2
		_GIIntensity ("_GIIntensity", Range(0, 1)) = 1
		_CubemapColor ("Cubemap Color", Vector) = (0,0,0,0)
		_RippleScale ("Ripple Scale", Float) = 1
		[Toggle(USERAIN)] _USERAIN ("Use rain (turn ripples on and water level is taken from rain intensity)", Float) = 1
		_EditorWaterLevel ("Water level (Use rain should be off)", Float) = 1
		_Temperature ("_Temperature", Vector) = (0.1,0.12,0.28,0)
	}
	//DummyShaderTextExporte = "Geometry+5" "RenderType" = "Opaque" }
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
			ColorMask RGB
			ZWrite Off
			GpuProgramID 22114
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
				float4 color : COLOR0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float _EditorWaterLevel;
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			samplerCUBE _Cube;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
