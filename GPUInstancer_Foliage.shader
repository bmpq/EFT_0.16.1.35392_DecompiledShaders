Shader "GPUInstancer/Foliage" {
	Properties {
		_Cutoff ("Mask Clip Value", Float) = 0.33
		_CutoffFade ("Cutoff Fade[start distance, end, start shadow, end shadow]", Vector) = (40,45,45,50)
		_WindWaveNormalTexture ("Wind Wave Normal Texture", 2D) = "bump" {}
		_DryColor ("Dry Color", Vector) = (1,0,0,0)
		_HealthyColor ("Healthy Color", Vector) = (0,1,0.2137935,0)
		_MainTex ("MainTex", 2D) = "white" {}
		_DensityMapIndex ("_DensityMapIndex", Float) = 0
		_DensityChanelMask ("_DensityChanelMask", Vector) = (0,0,0,0)
		[PerRendererData] _HeightMap ("_HeightMap", 2D) = "white" {}
		[PerRendererData] _AlphaMapArray ("_AlphaMapArray", 2DArray) = "" {}
		[PerRendererData] _DensityMapArray ("_DensityMapArray", 2DArray) = "" {}
		[PerRendererData] _TerrainSize ("_TerrainSize", Vector) = (1,1,1,1)
		[PerRendererData] _HeightResolution ("_HeightResolution", Float) = 1
		[PerRendererData] _TerrainWorldPos ("_TerrainWorldPos", Vector) = (0,0,0,0)
		[PerRendererData] _TerrainNormalMap ("Terrain Normal Map", 2D) = "bump" {}
		_AmbientOcclusion ("Ambient Occlusion", Range(0, 1)) = 0.5
		_NoiseSpread ("Noise Spread", Float) = 0.1
		_NormalMap ("Normal Map", 2D) = "bump" {}
		[Toggle] _IsBillboard ("IsBillboard", Float) = 0
		_WindWaveTintColor ("Wind Wave Tint Color", Vector) = (0.07586241,0,1,0)
		_HealthyDryNoiseTexture ("Healthy Dry Noise Texture", 2D) = "white" {}
		[Toggle] _WindWavesOn ("Wind Waves On", Float) = 0
		_WindWaveTint ("Wind Wave Tint", Range(0, 1)) = 0.5
		_WindWaveSway ("Wind Wave Sway", Range(0, 1)) = 0.5
		_WindIdleSway ("Wind Idle Sway", Range(0, 1)) = 0.6
		[Toggle(_BILLBOARDFACECAMPOS_ON)] _BillboardFaceCamPos ("BillboardFaceCamPos", Float) = 0
		[Toggle(_VERTEXFIT_ON)] [PerRendererData] _VERTEXFIT ("_VertexFit", Float) = 0
		[Toggle(_UseTerrainNormal_ON)] [PerRendererData] _UseTerrainNormal ("_UseTerrainNormal", Float) = 0
		[Toggle(_UseAlphaMask_ON)] [PerRendererData] _UseAlphaMask ("_UseAlphaMask_ON", Float) = 0
		[Toggle(_UseDensityMask_ON)] [PerRendererData] _UseDensityMask ("_UseDensityMask_ON",oat) = 0
		[PerRendererData] _GradientNormalHeight ("Gradient Normal Height", Float) = 1
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
		[HideInInspector] _TaaBias ("", Float) = -1.5
		[PerRendererData] _WaveAndDistance ("Wave and distance", Vector) = (12,3.6,1,1)
	}
	SubShader {
		Tags { "QUEUE" = "AlphaTest-351" "RenderType" = "GPUIFoliage" }
		Pass {
			Name "DepthPrePass"
			Tags { "LIGHTMODE" = "MOTIONVECTORS" }
			ColorMask 0
			ZTest Less
			Cull Off
			GpuProgramID 14681
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
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float _MipMapChecker;
			// Custom ConstantBuffers for Vertex Shader
			CBUFFER_START(RareUpdate)
			CBUFFER_END
			CBUFFER_START(InstaceRegular)
			CBUFFER_END
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
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0.xy = unity_ObjectToWorld._m03_m23 - cb3[3].xz;
                tmp0.xy = tmp0.xy / cb2[2].xx;
                tmp0.z = cb2[3].x - 1;
                tmp0.z = floor(tmp0.z);
                tmp0.xy = tmp0.zz * tmp0.xy;
                tmp0.w = floor(cb2[3].x);
                tmp0.xy = tmp0.xy / tmp0.ww;
                tmp1.x = 0.5 / tmp0.w;
                tmp0.xy = tmp0.xy + tmp1.xx;
                tmp2 = tex2Dlod(1, float4(tmp0.xy, 0, 0.0));
                tmp1.yzw = v.vertex.zzz * unity_ObjectToWorld._m02_m12_m22;
                tmp1.yzw = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp1.yzw;
                tmp1.yzw = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp1.yzw;
                tmp0.xy = tmp1.yw - cb3[3].xz;
                tmp1.y = unity_ObjectToWorld._m13 - tmp1.z;
                tmp0.xy = tmp0.xy / cb2[2].xx;
                tmp1.zw = tmp0.zz * tmp0.xy;
                tmp3 = tex2Dlod(2, float4(tmp0.xy, 0, 0.0));
                tmp0.xyz = tmp3.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
                tmp1.zw = tmp1.zw / tmp0.ww;
                tmp1.xz = tmp1.zw + tmp1.xx;
                tmp3 = tex2Dlod(1, float4(tmp1.xz, 0, 0.0));
                tmp0.w = tmp3.x - tmp2.x;
                tmp0.w = dot(tmp0.xy, cb2[2].xy);
                tmp0.w = tmp0.w + tmp1.y;
                tmp1.xyz = tmp0.yyy * unity_WorldToObject._m01_m11_m21;
                tmp1.xyz = unity_WorldToObject._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToObject._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                tmp1.x = dot(tmp0.xyz, tmp0.xyz);
                tmp1.x = rsqrt(tmp1.x);
                tmp1.yzw = tmp0.xyz * tmp1.xxx;
                tmp2.x = dot(unity_WorldToObject._m01_m11_m21, unity_WorldToObject._m01_m11_m21);
                tmp2.x = rsqrt(tmp2.x);
                tmp2.xyz = tmp2.xxx * unity_WorldToObject._m01_m11_m21;
                tmp1.y = dot(tmp2.xyz, tmp1.xyz);
                tmp1.z = tmp0.y * tmp1.x + -tmp1.y;
                tmp0.xyz = tmp0.xyz * tmp1.xxx + -tmp2.xyz;
                tmp1.x = 1.0 - tmp1.y;
                tmp1.x = saturate(tmp1.z / tmp1.x);
                tmp0.xyz = tmp1.xxx * tmp0.xyz + tmp2.xyz;
                tmp0.xyz = tmp0.xyz - float3(0.0, 1.0, 0.0);
                tmp0.xyz = tmp0.xyz * v.vertex.yyy;
                tmp0.xyz = unity_WorldToObject._m01_m11_m21 * tmp0.www + tmp0.xyz;
                tmp1.xyz = unity_ObjectToWorld._m03_m13_m23 - cb5[8].xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp0.w);
                tmp0.w = sqrt(tmp0.w);
                tmp2.x = tmp1.w * tmp1.y;
                tmp1.xy = tmp1.xz * tmp1.ww + cb5[9].xy;
                tmp1.zw = tmp2.xx * unity_WorldToObject._m01_m21;
                tmp1.xz = unity_WorldToObject._m00_m20 * tmp1.xx + tmp1.zw;
                tmp1.xy = unity_WorldToObject._m02_m22 * tmp1.yy + tmp1.xz;
                tmp1.z = dot(tmp1.xy, tmp1.xy);
                tmp1.z = rsqrt(tmp1.z);
                tmp1.xy = tmp1.zz * tmp1.xy;
                tmp1.xy = tmp1.xy * v.vertex.yy;
                tmp1.z = dot(tmp1.xy, tmp1.xy);
                tmp1.z = rsqrt(tmp1.z);
                tmp1.xy = tmp1.zz * tmp1.xy;
                tmp1.z = tmp0.w / cb5[10].z;
                tmp0.w = tmp0.w < cb5[10].z;
                tmp1.z = 1.0 - tmp1.z;
                tmp1.z = tmp1.z * tmp1.z;
                tmp2.xy = tmp1.zz * tmp1.xy;
                tmp1.xz = tmp1.xy * tmp1.zz + v.vertex.xz;
                tmp1.w = dot(tmp2.xy, tmp2.xy);
                tmp1.w = 1.0 - tmp1.w;
                tmp1.w = sqrt(tmp1.w);
                tmp1.y = tmp1.w * v.vertex.y;
                tmp1.w = v.vertex.y > 0.0;
                tmp0.w = tmp0.w ? tmp1.w : 0.0;
                tmp1.xyz = tmp0.www ? tmp1.xyz : v.vertex.xyz;
                tmp0.xyz = tmp0.xyz + tmp1.xyz;
                tmp1.x = cb1[9].x;
                tmp1.y = cb1[10].x;
                tmp1.z = cb1[11].x;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp2.y = abs(cb1[10].y);
                tmp2.x = cb1[9].y;
                tmp2.z = cb1[11].y;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp0.w = dot(unity_ObjectToWorld._m00_m10_m20, unity_ObjectToWorld._m00_m10_m20);
                tmp3.x = sqrt(tmp0.w);
                tmp0.w = dot(unity_ObjectToWorld._m01_m11_m21, unity_ObjectToWorld._m01_m11_m21);
                tmp3.y = sqrt(tmp0.w);
                tmp0.w = dot(unity_ObjectToWorld._m02_m12_m22, unity_ObjectToWorld._m02_m12_m22);
                tmp3.z = sqrt(tmp0.w);
                tmp3.xyz = tmp3.xyz * v.vertex.xyz;
                tmp2.xyz = tmp2.xyz * tmp3.yyy;
                tmp1.xyz = tmp3.xxx * tmp1.xyz + tmp2.xyz;
                tmp2.x = cb1[9].z;
                tmp2.y = cb1[10].z;
                tmp2.z = cb1[11].z;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp1.xyz = tmp3.zzz * -tmp2.xyz + tmp1.xyz;
                tmp1.xyz = tmp1.xyz + unity_ObjectToWorld._m03_m13_m23;
                tmp2.xyz = tmp1.yyy * unity_WorldToObject._m01_m11_m21;
                tmp1.xyw = unity_WorldToObject._m00_m10_m20 * tmp1.xxx + tmp2.xyz;
                tmp1.xyz = unity_WorldToObject._m02_m12_m22 * tmp1.zzz + tmp1.xyw;
                tmp0.w = cb3[0].x > 0.0;
                tmp0.xyz = tmp0.www ? tmp1.xyz : tmp0.xyz;
                tmp1.xy = v.vertex.yy * unity_ObjectToWorld._m01_m21;
                tmp1.xy = unity_ObjectToWorld._m00_m20 * v.vertex.xx + tmp1.xy;
                tmp1.xy = unity_ObjectToWorld._m02_m22 * v.vertex.zz + tmp1.xy;
                tmp1.xy = unity_ObjectToWorld._m03_m23 * v.vertex.ww + tmp1.xy;
                tmp0.w = -cb6[0].x * 0.9 + 1.0;
                tmp0.w = tmp0.w * 0.003;
                tmp1.z = cb4[1].w * 4.0 + 1.0;
                tmp1.zw = cb5[12].xy / tmp1.zz;
                tmp1.xy = tmp0.ww * tmp1.xy + tmp1.zw;
                tmp1.xy = tmp1.xy * float2(0.6, 0.6);
                tmp1 = tex2Dlod(0, float4(tmp1.xy, 0, 0.0));
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.xy = tmp1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp1.zw = tmp1.yy * cb5[11].xy;
                tmp0.w = cb4[0].z * 30.0;
                tmp1.zw = tmp1.zw * tmp0.ww;
                tmp0.w = cb4[0].x >= 1.0;
                tmp0.w = tmp0.w ? 1.0 : 0.0;
                tmp0.w = tmp0.w * tmp1.y;
                tmp1.xy = tmp1.xy * cb4[0].yy;
                tmp1 = tmp1 * v.vertex.yyyy;
                tmp1.zw = tmp0.ww * tmp1.zw;
                tmp1.xy = tmp1.xy * float2(1.5, 1.5) + -tmp1.zw;
                tmp0.w = dot(cb5[11].xy, cb5[11].xy);
                tmp0.w = sqrt(tmp0.w);
                tmp0.w = tmp0.w + 0.2;
                tmp0.w = min(tmp0.w, 1.0);
                tmp1.zw = v.vertex.yy * cb5[11].xy;
                tmp1.zw = tmp1.zw * float2(0.2, 0.2);
                tmp1.xy = tmp1.xy * tmp0.ww + tmp1.zw;
                tmp1.yzw = tmp1.yyy * unity_WorldToObject._m02_m12_m22;
                tmp1.xyz = unity_WorldToObject._m00_m10_m20 * tmp1.xxx + tmp1.yzw;
                tmp0.xyz = tmp0.xyz + tmp1.xyz;
                tmp1 = tmp0.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp1 = unity_ObjectToWorld._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp0 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp1 = tmp0.yyyy * cb1[18];
                tmp1 = cb1[17] * tmp0.xxxx + tmp1;
                tmp1 = cb1[19] * tmp0.zzzz + tmp1;
                o.position = cb1[20] * tmp0.wwww + tmp1;
                o.texcoord.xy = v.texcoord.xy;
                o.color.x = 0.0;
                o.color1.x = v.vertex.y;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
