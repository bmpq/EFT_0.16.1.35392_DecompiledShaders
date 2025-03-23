Shader "Decal/DeferredDecalDiffuseNormalsDynamicEditor" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("Stencil type to draw decals", Float) = 0
		_MainTex ("Diffuse", 2D) = "white" {}
		_MainTexArray ("DiffuseArray", 2DArray) = "" {}
		_Color ("Main color", Vector) = (1,1,1,1)
		_BumpMap ("Normals", 2D) = "bump" {}
		_BumpMapArray ("NormalsArray", 2DArray) = "" {}
		_NormalPower ("Normal power", Float) = 3
		_SpecularColor ("Specular color", Vector) = (1,1,1,1)
		_SpecSmoothness ("Specular smoothness", Range(0, 1)) = 0
		_AlphaMultiplier ("Alpha Multiplier", Float) = 1
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.11,0.25,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTUnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float4 texcoord : TEXCOORD0;
				float3 texcoord6 : TEXCOORD6;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord7 : TEXCOORD7;
				uint texcoord1 : TEXCOORD1;
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
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _NormalsCopy;
			UNITY_DECLARE_TEX2DARRAY(_MainTexArray);
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
