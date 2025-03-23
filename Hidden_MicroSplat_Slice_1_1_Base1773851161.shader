Shader "Hidden/MicroSplat/Slice_1_1_Base1773851161" {
	Properties {
		[HideInInspector] _Control0 ("Control0", 2D) = "red" {}
		[HideInInspector] _Control1 ("Control1", 2D) = "black" {}
		[HideInInspector] _Control2 ("Control2", 2D) = "black" {}
		[HideInInspector] _Control3 ("Control3", 2D) = "black" {}
		[NoScaleOffset] _Diffuse ("Diffuse Array", 2DArray) = "white" {}
		[NoScaleOffset] _NormalSAO ("Normal Array", 2DArray) = "bump" {}
		[NoScaleOffset] _PerTexProps ("Per Texture Properties", 2D) = "black" {}
		[HideInInspector] _TerrainHolesTexture ("Holes Map (RGB)", 2D) = "white" {}
		[HideInInspector] _PerPixelNormal ("Per Pixel Normal", 2D) = "bump" {}
		_Contrast ("Blend Contrast", Range(0.01, 0.99)) = 0.4
		_UVScale ("UV Scales", Vector) = (45,45,0,0)
		_MainTex ("Unity Bug", 2D) = "white" {}
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		}lse" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+100" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "SplatCount" = "16" "TerrainCompatible" = "true" }
			GpuProgramID 51760
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
				float4 texccoord3 : TEXCCOORD3;
				float4 texcoord8 : TEXCOORD8;
				float4 texcoord11 : TEXCOORD11;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _ThermalVisionOn;
			float4 _UVScale;
			float _Contrast;
			float4 _Control0_TexelSize;
			float4 _PerTexProps_TexelSize;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			UNITY_DECLARE_TEX2DARRAY(_Diffuse);
			UNITY_DECLARE_TEX2DARRAY(_NormalSAO);
			sampler2D _Control0;
			sampler2D _Control1;
			sampler2D _Control2;
			sampler2D _Control3;
			sampler2D _PerTexProps;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * cb0[1];
                tmp0 = cb0[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb0[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb0[3];
                o.texcoord.xyz = cb0[3].xyz * v.vertex.www + tmp0.xyz;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                tmp0.xyz = v.normal.yyy * cb0[1].xyz;
                tmp0.xyz = cb0[0].xyz * v.normal.xxx + tmp0.xyz;
                tmp0.xyz = cb0[2].xyz * v.normal.zzz + tmp0.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                o.texcoord1.xyz = tmp0.xyz;
                tmp1.xyz = tmp0.zxy * float3(0.0, 1.0, 0.0);
                o.texcoord2.xyz = tmp0.yzx * float3(1.0, 0.0, 0.0) + -tmp1.xyz;
                o.texcoord2.w = -1.0;
                o.texccoord3 = v.texcoord;
                o.texcoord8 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord11 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
