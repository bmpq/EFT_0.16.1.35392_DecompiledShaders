Shader "Custom/Glass2" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse (RGB) Specular (A)", 2D) = "white" {}
		[NoScaleOffset] _TransparentTex ("Transparent (R)", 2D) = "white" {}
		[NoScaleOffset] _Cube ("Reflection Cubemap", Cube) = "" {}
		[NoScaleOffset] [Normal] _BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_Specular ("_Specular", Range(0.01, 5)) = 0.078125
		_Glossness ("_Glossness", Range(0.01, 5)) = 0.078125
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
	}
	SubShader {
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			GpuProgramID 37486
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float texcoord4 : TEXCOORD4;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float3 TOD_SunSkyColor;
			float3 TOD_MoonSkyColor;
			float3 TOD_GroundColor;
			float3 TOD_MoonHaloColor;
			float3 TOD_LocalSunDirection;
			float3 TOD_LocalMoonDirection;
			float TOD_Contrast;
			float TOD_Brightness;
			float TOD_ScatteringBrightness;
			float TOD_Fogginess;
			float TOD_MoonHaloPower;
			float3 TOD_kBetaMie;
			float4 TOD_kSun;
			float4 TOD_k4PI;
			float4 TOD_kRadius;
			float4 TOD_kScale;
			float4 _Density;
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _Color;
			float3 _DefVals;
			float4 _EFT_Ambient;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _TransparentTex;
			sampler2D _BumpMap;
			
			// Keywords: DIRECTIONAL GAMMA LDR
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                float4 tmp5;
                float4 tmp6;
                float4 tmp7;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp1.xyz = tmp0.xyz - _WorldSpaceCameraPos;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = sqrt(tmp0.w);
                tmp2.x = tmp1.y + _Density.y;
                tmp2.x = tmp2.x * _Density.x;
                tmp2.x = max(tmp2.x, 0.0);
                tmp2.x = tmp2.x + 1.0;
                tmp2.x = 1.0 / tmp2.x;
                tmp1.w = tmp1.w * tmp2.x;
                tmp1.w = tmp1.w * _Density.z;
                tmp1.w = min(tmp1.w, 10.0);
                tmp1.w = tmp1.w * -1.442695;
                tmp1.w = exp(tmp1.w);
                tmp1.w = 1.0 - tmp1.w;
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp1.xyz;
                tmp0.w = tmp1.y * tmp0.w + 0.03125;
                tmp1.xy = tmp2.yy > float2(0.03125, -0.03125);
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = tmp0.w * 8.0;
                tmp0.w = tmp1.x ? tmp2.y : tmp0.w;
                tmp2.w = tmp1.y ? tmp0.w : 0.0;
                tmp0.w = tmp1.w * TOD_kScale.x;
                tmp1.y = TOD_kRadius.x + TOD_kScale.w;
                tmp3.x = tmp2.w * tmp2.w;
                tmp3.x = tmp3.x * TOD_kRadius.y + TOD_kRadius.w;
                tmp3.x = tmp3.x - TOD_kRadius.y;
                tmp3.x = sqrt(tmp3.x);
                tmp3.x = -TOD_kRadius.x * tmp2.w + tmp3.x;
                tmp3.y = -TOD_kScale.w * TOD_kScale.z;
                tmp3.xy = tmp3.xy * float2(0.25, 1.442695);
                tmp3.y = exp(tmp3.y);
                tmp3.z = tmp1.y * tmp2.w;
                tmp3.z = tmp3.z / tmp1.y;
                tmp3.z = 1.0 - tmp3.z;
                tmp3.w = tmp3.z * 5.25 + -6.8;
                tmp3.w = tmp3.z * tmp3.w + 3.83;
                tmp3.w = tmp3.z * tmp3.w + 0.459;
                tmp3.z = tmp3.z * tmp3.w + -0.00287;
                tmp3.z = tmp3.z * 1.442695;
                tmp3.z = exp(tmp3.z);
                tmp3.y = tmp3.z * tmp3.y;
                tmp0.w = tmp0.w * tmp3.x;
                tmp4.xyz = tmp2.xwz * tmp3.xxx;
                tmp1.xz = float2(0.0, 0.0);
                tmp1.xyz = tmp4.xyz * float3(0.5, 0.5, 0.5) + tmp1.xyz;
                tmp4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
                tmp5.xyz = tmp1.xyz;
                tmp6.xyz = float3(0.0, 0.0, 0.0);
                tmp3.z = 0.0;
                for (int i = tmp3.z; i < 4; i += 1) {
                    tmp3.w = dot(tmp5.xyz, tmp5.xyz);
                    tmp3.w = sqrt(tmp3.w);
                    tmp4.w = 1.0 / tmp3.w;
                    tmp3.w = TOD_kRadius.x - tmp3.w;
                    tmp3.w = tmp3.w * TOD_kScale.z;
                    tmp3.w = tmp3.w * 1.442695;
                    tmp3.w = exp(tmp3.w);
                    tmp5.w = tmp0.w * tmp3.w;
                    tmp6.w = dot(tmp2.xyz, tmp5.xyz);
                    tmp7.x = dot(TOD_LocalSunDirection, tmp5.xyz);
                    tmp7.x = -tmp7.x * tmp4.w + 1.0;
                    tmp7.y = tmp7.x * 5.25 + -6.8;
                    tmp7.y = tmp7.x * tmp7.y + 3.83;
                    tmp7.y = tmp7.x * tmp7.y + 0.459;
                    tmp7.x = tmp7.x * tmp7.y + -0.00287;
                    tmp7.x = tmp7.x * 1.442695;
                    tmp7.x = exp(tmp7.x);
                    tmp4.w = -tmp6.w * tmp4.w + 1.0;
                    tmp6.w = tmp4.w * 5.25 + -6.8;
                    tmp6.w = tmp4.w * tmp6.w + 3.83;
                    tmp6.w = tmp4.w * tmp6.w + 0.459;
                    tmp4.w = tmp4.w * tmp6.w + -0.00287;
                    tmp4.w = tmp4.w * 1.442695;
                    tmp4.w = exp(tmp4.w);
                    tmp4.w = tmp4.w * 0.25;
                    tmp4.w = tmp7.x * 0.25 + -tmp4.w;
                    tmp3.w = tmp3.w * tmp4.w;
                    tmp3.w = tmp3.y * 0.25 + tmp3.w;
                    tmp7.xyz = tmp4.xyz * -tmp3.www;
                    tmp7.xyz = tmp7.xyz * float3(1.442695, 1.442695, 1.442695);
                    tmp7.xyz = exp(tmp7.xyz);
                    tmp6.xyz = tmp7.xyz * tmp5.www + tmp6.xyz;
                    tmp5.xyz = tmp2.xwz * tmp3.xxx + tmp5.xyz;
                }
                tmp1.xyz = tmp6.xyz * TOD_SunSkyColor;
                tmp3.xyz = tmp1.xyz * TOD_kSun.xyz;
                tmp1.xyz = tmp1.xyz * TOD_kSun.www;
                tmp0.w = saturate(tmp2.y * -0.8);
                tmp2.w = tmp0.w * -2.0 + 3.0;
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = tmp0.w * tmp2.w;
                tmp2.w = dot(TOD_LocalSunDirection, tmp2.xyz);
                tmp3.w = tmp2.w * tmp2.w;
                tmp3.w = tmp3.w * 0.75 + 0.75;
                tmp4.x = tmp2.w * tmp2.w + 1.0;
                tmp4.x = tmp4.x * TOD_kBetaMie.x;
                tmp2.w = TOD_kBetaMie.z * tmp2.w + TOD_kBetaMie.y;
                tmp2.w = log(tmp2.w);
                tmp2.w = tmp2.w * 1.5;
                tmp2.w = exp(tmp2.w);
                tmp2.w = tmp4.x / tmp2.w;
                tmp1.xyz = tmp1.xyz * tmp2.www;
                tmp1.xyz = tmp3.www * tmp3.xyz + tmp1.xyz;
                tmp3.xyz = tmp2.yyy * -TOD_MoonSkyColor + TOD_MoonSkyColor;
                tmp1.xyz = tmp1.xyz + tmp3.xyz;
                tmp2.x = dot(tmp2.xyz, TOD_LocalMoonDirection);
                tmp2.x = max(tmp2.x, 0.0);
                tmp2.x = log(tmp2.x);
                tmp2.x = tmp2.x * TOD_MoonHaloPower;
                tmp2.x = exp(tmp2.x);
                tmp1.xyz = TOD_MoonHaloColor * tmp2.xxx + tmp1.xyz;
                tmp2.x = tmp1.y + tmp1.x;
                tmp2.x = tmp1.z + tmp2.x;
                tmp2.xyz = tmp2.xxx * float3(0.333, 0.333, 0.333) + -tmp1.xyz;
                tmp1.xyz = TOD_Fogginess.xxx * tmp2.xyz + tmp1.xyz;
                tmp2.xyz = TOD_GroundColor - tmp1.xyz;
                tmp1.xyz = tmp0.www * tmp2.xyz + tmp1.xyz;
                tmp1.xyz = tmp1.xyz * TOD_ScatteringBrightness.xxx;
                tmp1.xyz = log(tmp1.xyz);
                tmp1.xyz = tmp1.xyz * TOD_Contrast.xxx;
                tmp1.xyz = exp(tmp1.xyz);
                tmp1.xyz = tmp1.xyz + tmp1.xyz;
                tmp1.xyz = tmp1.xyz * -TOD_Brightness.xxx;
                tmp1.xyz = exp(tmp1.xyz);
                tmp1.xyz = float3(1.0, 1.0, 1.0) - tmp1.xyz;
                tmp1.xyz = sqrt(tmp1.xyz);
                tmp1.xyz = tmp1.xyz - float3(0.0000001, 0.0000001, 0.0000001);
                o.texcoord5.xyz = max(tmp1.xyz, float3(0.0, 0.0, 0.0));
                tmp2 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp2 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp2;
                tmp2 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp2;
                tmp2 = tmp2 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp3 = tmp2.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp3 = unity_MatrixVP._m00_m10_m20_m30 * tmp2.xxxx + tmp3;
                tmp3 = unity_MatrixVP._m02_m12_m22_m32 * tmp2.zzzz + tmp3;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp2.wwww + tmp3;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2 = tmp0.wwww * tmp1.xyzz;
                tmp1.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp1.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp1.xyz;
                tmp1.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp1.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp0.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp3.xyz = tmp1.xyz * tmp2.wxy;
                tmp3.xyz = tmp2.ywx * tmp1.yzx + -tmp3.xyz;
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp4 = tmp2.ywzx * tmp2;
                tmp5.x = dot(unity_SHBr, tmp4);
                tmp5.y = dot(unity_SHBg, tmp4);
                tmp5.z = dot(unity_SHBb, tmp4);
                tmp0.w = tmp2.y * tmp2.y;
                tmp0.w = tmp2.x * tmp2.x + -tmp0.w;
                o.texcoord6.xyz = unity_SHC.xyz * tmp0.www + tmp5.xyz;
                o.texcoord1.x = tmp1.z;
                o.texcoord1.y = tmp3.x;
                o.texcoord1.z = tmp2.x;
                o.texcoord1.w = tmp0.x;
                o.texcoord2.x = tmp1.x;
                o.texcoord2.y = tmp3.y;
                o.texcoord2.z = tmp2.y;
                o.texcoord2.w = tmp0.y;
                o.texcoord3.x = tmp1.y;
                o.texcoord3.y = tmp3.z;
                o.texcoord3.z = tmp2.w;
                o.texcoord3.w = tmp0.z;
                o.texcoord5.w = tmp1.w;
                o.texcoord4.x = 0.0;
                return o;
			}
			// Keywords: DIRECTIONAL GAMMA LDR
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                float4 tmp5;
                float4 tmp6;
                tmp0.y = inp.texcoord1.w;
                tmp0.z = inp.texcoord2.w;
                tmp0.w = inp.texcoord3.w;
                tmp1.xyz = _WorldSpaceCameraPos - tmp0.yzw;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp2.xyz = tmp1.yyy * inp.texcoord2.xyz;
                tmp1.xyw = inp.texcoord1.xyz * tmp1.xxx + tmp2.xyz;
                tmp1.xyz = inp.texcoord3.xyz * tmp1.zzz + tmp1.xyw;
                tmp2 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * _Color.xyz;
                tmp3 = tex2D(_TransparentTex, inp.texcoord.xy);
                o.sv_target.w = tmp3.x * _Color.w;
                tmp3 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.x = dot(tmp3.xy, tmp3.xy);
                tmp0.x = min(tmp0.x, 1.0);
                tmp0.x = 1.0 - tmp0.x;
                tmp3.z = sqrt(tmp0.x);
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(tmp1.xyz, tmp3.xyz);
                tmp0.x = 1.0 - tmp0.x;
                tmp0.x = tmp0.x * tmp0.x;
                tmp0.x = _DefVals.y * tmp0.x + _DefVals.x;
                tmp1.xyz = tmp0.xxx * tmp2.xyz;
                tmp2.xyz = tmp1.xyz * _EFT_Ambient.xyz;
                tmp4.xyz = tmp2.xyz + tmp2.xyz;
                tmp2.xyz = -tmp2.xyz * float3(2.0, 2.0, 2.0) + inp.texcoord5.xyz;
                tmp2.xyz = inp.texcoord5.www * tmp2.xyz + tmp4.xyz;
                tmp0.x = unity_ProbeVolumeParams.x == 1.0;
                if (tmp0.x) {
                    tmp1.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp4.xyz = tmp1.www ? tmp4.xyz : tmp0.yzw;
                    tmp4.xyz = tmp4.xyz - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp4.xyz * unity_ProbeVolumeSizeInv;
                    tmp1.w = tmp4.y * 0.25 + 0.75;
                    tmp2.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp1.w, tmp2.w);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp1.w = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp4.x = dot(inp.texcoord1.xyz, tmp3.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp2.w = dot(tmp4.xyz, tmp4.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp3.xyz = tmp2.www * tmp4.xyz;
                tmp4.xyz = tmp1.www * _LightColor0.xyz;
                if (tmp0.x) {
                    tmp0.x = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.xyz = tmp0.xxx ? tmp5.xyz : tmp0.yzw;
                    tmp0.xyz = tmp0.xyz - unity_ProbeVolumeMin;
                    tmp0.yzw = tmp0.xyz * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp0.y * 0.25;
                    tmp1.w = unity_ProbeVolumeParams.z * 0.5;
                    tmp2.w = -unity_ProbeVolumeParams.z * 0.5 + 0.25;
                    tmp0.y = max(tmp0.y, tmp1.w);
                    tmp0.x = min(tmp2.w, tmp0.y);
                    tmp5 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.xzw);
                    tmp6.xyz = tmp0.xzw + float3(0.25, 0.0, 0.0);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp6.xyz);
                    tmp0.xyz = tmp0.xzw + float3(0.5, 0.0, 0.0);
                    tmp0 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.xyz);
                    tmp3.w = 1.0;
                    tmp5.x = dot(tmp5, tmp3);
                    tmp5.y = dot(tmp6, tmp3);
                    tmp5.z = dot(tmp0, tmp3);
                } else {
                    tmp3.w = 1.0;
                    tmp5.x = dot(unity_SHAr, tmp3);
                    tmp5.y = dot(unity_SHAg, tmp3);
                    tmp5.z = dot(unity_SHAb, tmp3);
                }
                tmp0.xyz = tmp5.xyz + inp.texcoord6.xyz;
                tmp0.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                tmp0.xyz = log(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * float3(0.4166667, 0.4166667, 0.4166667);
                tmp0.xyz = exp(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * float3(1.055, 1.055, 1.055) + float3(-0.055, -0.055, -0.055);
                tmp0.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                tmp0.w = dot(tmp3.xyz, _WorldSpaceLightPos0.xyz);
                tmp0.w = max(tmp0.w, 0.0);
                tmp3.xyz = tmp1.xyz * tmp4.xyz;
                tmp0.xyz = tmp0.xyz * tmp1.xyz;
                tmp0.xyz = tmp3.xyz * tmp0.www + tmp0.xyz;
                o.sv_target.xyz = tmp2.xyz + tmp0.xyz;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 130822
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float texcoord5 : TEXCOORD5;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float4 texcoord6 : TEXCOORD6;
				float3 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 unity_WorldToLight;
			float3 TOD_SunSkyColor;
			float3 TOD_MoonSkyColor;
			float3 TOD_GroundColor;
			float3 TOD_MoonHaloColor;
			float3 TOD_LocalSunDirection;
			float3 TOD_LocalMoonDirection;
			float TOD_Contrast;
			float TOD_Brightness;
			float TOD_ScatteringBrightness;
			float TOD_Fogginess;
			float TOD_MoonHaloPower;
			float3 TOD_kBetaMie;
			float4 TOD_kSun;
			float4 TOD_k4PI;
			float4 TOD_kRadius;
			float4 TOD_kScale;
			float4 _Density;
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _Color;
			float3 _DefVals;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _TransparentTex;
			sampler2D _BumpMap;
			sampler2D _LightTexture0;
			
			// Keywords: GAMMA LDR POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                float4 tmp5;
                float4 tmp6;
                float4 tmp7;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp1.xyz = tmp0.xyz - _WorldSpaceCameraPos;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = sqrt(tmp0.w);
                tmp2.x = tmp1.y + _Density.y;
                tmp2.x = tmp2.x * _Density.x;
                tmp2.x = max(tmp2.x, 0.0);
                tmp2.x = tmp2.x + 1.0;
                tmp2.x = 1.0 / tmp2.x;
                tmp1.w = tmp1.w * tmp2.x;
                tmp1.w = tmp1.w * _Density.z;
                tmp1.w = min(tmp1.w, 10.0);
                tmp1.w = tmp1.w * -1.442695;
                tmp1.w = exp(tmp1.w);
                tmp1.w = 1.0 - tmp1.w;
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp1.xyz;
                tmp0.w = tmp1.y * tmp0.w + 0.03125;
                tmp1.xy = tmp2.yy > float2(0.03125, -0.03125);
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = tmp0.w * 8.0;
                tmp0.w = tmp1.x ? tmp2.y : tmp0.w;
                tmp2.w = tmp1.y ? tmp0.w : 0.0;
                tmp0.w = tmp1.w * TOD_kScale.x;
                tmp1.y = TOD_kRadius.x + TOD_kScale.w;
                tmp3.x = tmp2.w * tmp2.w;
                tmp3.x = tmp3.x * TOD_kRadius.y + TOD_kRadius.w;
                tmp3.x = tmp3.x - TOD_kRadius.y;
                tmp3.x = sqrt(tmp3.x);
                tmp3.x = -TOD_kRadius.x * tmp2.w + tmp3.x;
                tmp3.y = -TOD_kScale.w * TOD_kScale.z;
                tmp3.xy = tmp3.xy * float2(0.25, 1.442695);
                tmp3.y = exp(tmp3.y);
                tmp3.z = tmp1.y * tmp2.w;
                tmp3.z = tmp3.z / tmp1.y;
                tmp3.z = 1.0 - tmp3.z;
                tmp3.w = tmp3.z * 5.25 + -6.8;
                tmp3.w = tmp3.z * tmp3.w + 3.83;
                tmp3.w = tmp3.z * tmp3.w + 0.459;
                tmp3.z = tmp3.z * tmp3.w + -0.00287;
                tmp3.z = tmp3.z * 1.442695;
                tmp3.z = exp(tmp3.z);
                tmp3.y = tmp3.z * tmp3.y;
                tmp0.w = tmp0.w * tmp3.x;
                tmp4.xyz = tmp2.xwz * tmp3.xxx;
                tmp1.xz = float2(0.0, 0.0);
                tmp1.xyz = tmp4.xyz * float3(0.5, 0.5, 0.5) + tmp1.xyz;
                tmp4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
                tmp5.xyz = tmp1.xyz;
                tmp6.xyz = float3(0.0, 0.0, 0.0);
                tmp3.z = 0.0;
                for (int i = tmp3.z; i < 4; i += 1) {
                    tmp3.w = dot(tmp5.xyz, tmp5.xyz);
                    tmp3.w = sqrt(tmp3.w);
                    tmp4.w = 1.0 / tmp3.w;
                    tmp3.w = TOD_kRadius.x - tmp3.w;
                    tmp3.w = tmp3.w * TOD_kScale.z;
                    tmp3.w = tmp3.w * 1.442695;
                    tmp3.w = exp(tmp3.w);
                    tmp5.w = tmp0.w * tmp3.w;
                    tmp6.w = dot(tmp2.xyz, tmp5.xyz);
                    tmp7.x = dot(TOD_LocalSunDirection, tmp5.xyz);
                    tmp7.x = -tmp7.x * tmp4.w + 1.0;
                    tmp7.y = tmp7.x * 5.25 + -6.8;
                    tmp7.y = tmp7.x * tmp7.y + 3.83;
                    tmp7.y = tmp7.x * tmp7.y + 0.459;
                    tmp7.x = tmp7.x * tmp7.y + -0.00287;
                    tmp7.x = tmp7.x * 1.442695;
                    tmp7.x = exp(tmp7.x);
                    tmp4.w = -tmp6.w * tmp4.w + 1.0;
                    tmp6.w = tmp4.w * 5.25 + -6.8;
                    tmp6.w = tmp4.w * tmp6.w + 3.83;
                    tmp6.w = tmp4.w * tmp6.w + 0.459;
                    tmp4.w = tmp4.w * tmp6.w + -0.00287;
                    tmp4.w = tmp4.w * 1.442695;
                    tmp4.w = exp(tmp4.w);
                    tmp4.w = tmp4.w * 0.25;
                    tmp4.w = tmp7.x * 0.25 + -tmp4.w;
                    tmp3.w = tmp3.w * tmp4.w;
                    tmp3.w = tmp3.y * 0.25 + tmp3.w;
                    tmp7.xyz = tmp4.xyz * -tmp3.www;
                    tmp7.xyz = tmp7.xyz * float3(1.442695, 1.442695, 1.442695);
                    tmp7.xyz = exp(tmp7.xyz);
                    tmp6.xyz = tmp7.xyz * tmp5.www + tmp6.xyz;
                    tmp5.xyz = tmp2.xwz * tmp3.xxx + tmp5.xyz;
                }
                tmp1.xyz = tmp6.xyz * TOD_SunSkyColor;
                tmp3.xyz = tmp1.xyz * TOD_kSun.xyz;
                tmp1.xyz = tmp1.xyz * TOD_kSun.www;
                tmp0.w = saturate(tmp2.y * -0.8);
                tmp2.w = tmp0.w * -2.0 + 3.0;
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = tmp0.w * tmp2.w;
                tmp2.w = dot(TOD_LocalSunDirection, tmp2.xyz);
                tmp3.w = tmp2.w * tmp2.w;
                tmp3.w = tmp3.w * 0.75 + 0.75;
                tmp4.x = tmp2.w * tmp2.w + 1.0;
                tmp4.x = tmp4.x * TOD_kBetaMie.x;
                tmp2.w = TOD_kBetaMie.z * tmp2.w + TOD_kBetaMie.y;
                tmp2.w = log(tmp2.w);
                tmp2.w = tmp2.w * 1.5;
                tmp2.w = exp(tmp2.w);
                tmp2.w = tmp4.x / tmp2.w;
                tmp1.xyz = tmp1.xyz * tmp2.www;
                tmp1.xyz = tmp3.www * tmp3.xyz + tmp1.xyz;
                tmp3.xyz = tmp2.yyy * -TOD_MoonSkyColor + TOD_MoonSkyColor;
                tmp1.xyz = tmp1.xyz + tmp3.xyz;
                tmp2.x = dot(tmp2.xyz, TOD_LocalMoonDirection);
                tmp2.x = max(tmp2.x, 0.0);
                tmp2.x = log(tmp2.x);
                tmp2.x = tmp2.x * TOD_MoonHaloPower;
                tmp2.x = exp(tmp2.x);
                tmp1.xyz = TOD_MoonHaloColor * tmp2.xxx + tmp1.xyz;
                tmp2.x = tmp1.y + tmp1.x;
                tmp2.x = tmp1.z + tmp2.x;
                tmp2.xyz = tmp2.xxx * float3(0.333, 0.333, 0.333) + -tmp1.xyz;
                tmp1.xyz = TOD_Fogginess.xxx * tmp2.xyz + tmp1.xyz;
                tmp2.xyz = TOD_GroundColor - tmp1.xyz;
                tmp1.xyz = tmp0.www * tmp2.xyz + tmp1.xyz;
                tmp1.xyz = tmp1.xyz * TOD_ScatteringBrightness.xxx;
                tmp1.xyz = log(tmp1.xyz);
                tmp1.xyz = tmp1.xyz * TOD_Contrast.xxx;
                tmp1.xyz = exp(tmp1.xyz);
                tmp1.xyz = tmp1.xyz + tmp1.xyz;
                tmp1.xyz = tmp1.xyz * -TOD_Brightness.xxx;
                tmp1.xyz = exp(tmp1.xyz);
                tmp1.xyz = float3(1.0, 1.0, 1.0) - tmp1.xyz;
                tmp1.xyz = sqrt(tmp1.xyz);
                tmp1.xyz = tmp1.xyz - float3(0.0000001, 0.0000001, 0.0000001);
                o.texcoord6.xyz = max(tmp1.xyz, float3(0.0, 0.0, 0.0));
                tmp2 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp2 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp2;
                tmp2 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp2;
                tmp3 = tmp2 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp4 = tmp3.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp4 = unity_MatrixVP._m00_m10_m20_m30 * tmp3.xxxx + tmp4;
                tmp4 = unity_MatrixVP._m02_m12_m22_m32 * tmp3.zzzz + tmp4;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp3.wwww + tmp4;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp3.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp3.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp3.xyz;
                tmp3.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp3.xyz;
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp4.xyz = tmp1.xyz * tmp3.xyz;
                tmp4.xyz = tmp1.zxy * tmp3.yzx + -tmp4.xyz;
                tmp4.xyz = tmp0.www * tmp4.xyz;
                tmp2 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp2;
                tmp5.xyz = tmp2.yyy * unity_WorldToLight._m01_m11_m21;
                tmp5.xyz = unity_WorldToLight._m00_m10_m20 * tmp2.xxx + tmp5.xyz;
                tmp2.xyz = unity_WorldToLight._m02_m12_m22 * tmp2.zzz + tmp5.xyz;
                o.texcoord7.xyz = unity_WorldToLight._m03_m13_m23 * tmp2.www + tmp2.xyz;
                o.texcoord6.w = tmp1.w;
                o.texcoord5.x = 0.0;
                o.texcoord1.x = tmp3.z;
                o.texcoord1.y = tmp4.x;
                o.texcoord1.z = tmp1.y;
                o.texcoord2.x = tmp3.x;
                o.texcoord2.y = tmp4.y;
                o.texcoord2.z = tmp1.z;
                o.texcoord3.x = tmp3.y;
                o.texcoord3.y = tmp4.z;
                o.texcoord3.z = tmp1.x;
                o.texcoord4.xyz = tmp0.xyz;
                return o;
			}
			// Keywords: GAMMA LDR POINT
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord4.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1.xyz = _WorldSpaceCameraPos - inp.texcoord4.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp2.xyz = tmp1.yyy * inp.texcoord2.xyz;
                tmp1.xyw = inp.texcoord1.xyz * tmp1.xxx + tmp2.xyz;
                tmp1.xyz = inp.texcoord3.xyz * tmp1.zzz + tmp1.xyw;
                tmp2 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * _Color.xyz;
                tmp3 = tex2D(_TransparentTex, inp.texcoord.xy);
                o.sv_target.w = tmp3.x * _Color.w;
                tmp3 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp3.xy, tmp3.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp3.z = sqrt(tmp0.w);
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp0.w = dot(tmp1.xyz, tmp3.xyz);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = _DefVals.y * tmp0.w + _DefVals.x;
                tmp1.xyz = tmp0.www * tmp2.xyz;
                tmp2.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp2.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp2.xyz;
                tmp2.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp2.xyz;
                tmp2.xyz = tmp2.xyz + unity_WorldToLight._m03_m13_m23;
                tmp0.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp0.w) {
                    tmp0.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord4.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord4.xxx + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.zzz + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp4.xyz = tmp0.www ? tmp4.xyz : inp.texcoord4.xyz;
                    tmp4.xyz = tmp4.xyz - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp4.xyz * unity_ProbeVolumeSizeInv;
                    tmp0.w = tmp4.y * 0.25 + 0.75;
                    tmp1.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp0.w, tmp1.w);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.w = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp2 = tex2D(_LightTexture0, tmp1.ww);
                tmp0.w = tmp0.w * tmp2.x;
                tmp2.x = dot(inp.texcoord1.xyz, tmp3.xyz);
                tmp2.y = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp2.z = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3.xyz = tmp0.www * _LightColor0.xyz;
                tmp0.x = dot(tmp2.xyz, tmp0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp0.yzw = tmp1.xyz * tmp3.xyz;
                o.sv_target.xyz = tmp0.xxx * tmp0.yzw;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 190994
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _SpecColor;
			float _Specular;
			float _Glossness;
			float3 _SpecVals;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			
			// Keywords: DIRECTIONAL GAMMA LDR
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord1.w = tmp0.x;
                tmp1.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp1.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp1.xyz;
                tmp1.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp1.xyz;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                o.texcoord1.x = tmp1.z;
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.x = dot(tmp2.xyz, tmp2.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2 = tmp0.xxxx * tmp2.xyzz;
                tmp3.xyz = tmp1.xyz * tmp2.wxy;
                tmp3.xyz = tmp2.ywx * tmp1.yzx + -tmp3.xyz;
                tmp0.x = v.tangent.w * unity_WorldTransformParams.w;
                tmp3.xyz = tmp0.xxx * tmp3.xyz;
                o.texcoord1.y = tmp3.x;
                o.texcoord1.z = tmp2.x;
                o.texcoord2.x = tmp1.x;
                o.texcoord3.x = tmp1.y;
                o.texcoord2.w = tmp0.y;
                o.texcoord3.w = tmp0.z;
                o.texcoord2.y = tmp3.y;
                o.texcoord3.y = tmp3.z;
                o.texcoord2.z = tmp2.y;
                o.texcoord3.z = tmp2.w;
                tmp0.x = tmp2.y * tmp2.y;
                tmp0.x = tmp2.x * tmp2.x + -tmp0.x;
                tmp1 = tmp2.ywzx * tmp2;
                tmp2.x = dot(unity_SHBr, tmp1);
                tmp2.y = dot(unity_SHBg, tmp1);
                tmp2.z = dot(unity_SHBb, tmp1);
                o.texcoord4.xyz = unity_SHC.xyz * tmp0.xxx + tmp2.xyz;
                o.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: DIRECTIONAL GAMMA LDR
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0.y = inp.texcoord1.w;
                tmp0.z = inp.texcoord2.w;
                tmp0.w = inp.texcoord3.w;
                tmp1.xyz = _WorldSpaceCameraPos - tmp0.yzw;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2.xyz = tmp0.xxx * tmp1.xyz;
                tmp3.xyz = tmp2.yyy * inp.texcoord2.xyz;
                tmp3.xyz = inp.texcoord1.xyz * tmp2.xxx + tmp3.xyz;
                tmp3.xyz = inp.texcoord3.xyz * tmp2.zzz + tmp3.xyz;
                tmp4 = tex2D(_MainTex, inp.texcoord.xy);
                tmp1.w = tmp4.w * _Glossness;
                tmp4 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp4.x = tmp4.w * tmp4.x;
                tmp4.xy = tmp4.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp4.xy, tmp4.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp4.z = sqrt(tmp2.w);
                tmp2.w = dot(tmp3.xyz, tmp3.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp3.xyz = tmp2.www * tmp3.xyz;
                tmp2.w = dot(tmp3.xyz, tmp4.xyz);
                tmp2.w = 1.0 - tmp2.w;
                tmp2.w = tmp2.w * tmp2.w;
                tmp2.w = tmp2.w * _SpecVals.y;
                tmp2.w = tmp2.w * 0.5 + _SpecVals.x;
                tmp1.w = tmp1.w * tmp2.w;
                tmp1.w = tmp1.w * 0.5;
                tmp3.x = dot(inp.texcoord1.xyz, tmp4.xyz);
                tmp3.y = dot(inp.texcoord2.xyz, tmp4.xyz);
                tmp3.z = dot(inp.texcoord3.xyz, tmp4.xyz);
                tmp2.w = dot(-tmp2.xyz, tmp3.xyz);
                tmp2.w = tmp2.w + tmp2.w;
                tmp2.xyz = tmp3.xyz * -tmp2.www + -tmp2.xyz;
                tmp2 = texCUBE(_Cube, tmp2.xyz);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp2.www ? tmp4.xyz : tmp0.yzw;
                    tmp0.yzw = tmp0.yzw - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp0.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp4.y * 0.25 + 0.75;
                    tmp0.z = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp0.z, tmp0.y);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.y = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp0.z = dot(tmp3.xyz, tmp3.xyz);
                tmp0.z = rsqrt(tmp0.z);
                tmp3.xyz = tmp0.zzz * tmp3.xyz;
                tmp0.yzw = tmp0.yyy * _LightColor0.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.xxx + _WorldSpaceLightPos0.xyz;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(tmp3.xyz, tmp1.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp1.x = _Specular * 128.0;
                tmp0.x = log(tmp0.x);
                tmp0.x = tmp0.x * tmp1.x;
                tmp0.x = exp(tmp0.x);
                tmp0.x = tmp1.w * tmp0.x;
                tmp0.yzw = tmp0.yzw * _SpecColor.xyz;
                o.sv_target.xyz = tmp0.yzw * tmp0.xxx + tmp2.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 257834
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 unity_WorldToLight;
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _SpecColor;
			float _Specular;
			float _Glossness;
			float3 _SpecVals;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _LightTexture0;
			
			// Keywords: GAMMA LDR POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp1.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp1.xyz = tmp1.www * tmp1.xyz;
                tmp2.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp2.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp2.xyz;
                tmp2.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp2.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3.xyz = tmp1.xyz * tmp2.xyz;
                tmp3.xyz = tmp1.zxy * tmp2.yzx + -tmp3.xyz;
                tmp1.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp3.xyz = tmp1.www * tmp3.xyz;
                o.texcoord1.y = tmp3.x;
                o.texcoord1.x = tmp2.z;
                o.texcoord1.z = tmp1.y;
                o.texcoord2.x = tmp2.x;
                o.texcoord3.x = tmp2.y;
                o.texcoord2.z = tmp1.z;
                o.texcoord3.z = tmp1.x;
                o.texcoord2.y = tmp3.y;
                o.texcoord3.y = tmp3.z;
                o.texcoord4.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord5.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                o.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: GAMMA LDR POINT
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord4.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = _WorldSpaceCameraPos - inp.texcoord4.xyz;
                tmp1.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp1.xyz = tmp1.www * tmp1.xyz;
                tmp2.xyz = tmp1.yyy * inp.texcoord2.xyz;
                tmp2.xyz = inp.texcoord1.xyz * tmp1.xxx + tmp2.xyz;
                tmp2.xyz = inp.texcoord3.xyz * tmp1.zzz + tmp2.xyz;
                tmp3 = tex2D(_MainTex, inp.texcoord.xy);
                tmp1.w = tmp3.w * _Glossness;
                tmp3 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp3.xy, tmp3.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp3.z = sqrt(tmp2.w);
                tmp2.w = dot(tmp2.xyz, tmp2.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp2.xyz = tmp2.www * tmp2.xyz;
                tmp2.x = dot(tmp2.xyz, tmp3.xyz);
                tmp2.x = 1.0 - tmp2.x;
                tmp2.x = tmp2.x * tmp2.x;
                tmp2.x = tmp2.x * _SpecVals.y;
                tmp2.x = tmp2.x * 0.5 + _SpecVals.x;
                tmp1.w = tmp1.w * tmp2.x;
                tmp1.w = tmp1.w * 0.5;
                tmp2.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp2.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp2.xyz;
                tmp2.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp2.xyz;
                tmp2.xyz = tmp2.xyz + unity_WorldToLight._m03_m13_m23;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord4.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord4.xxx + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.zzz + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp4.xyz = tmp2.www ? tmp4.xyz : inp.texcoord4.xyz;
                    tmp4.xyz = tmp4.xyz - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp4.xyz * unity_ProbeVolumeSizeInv;
                    tmp2.w = tmp4.y * 0.25 + 0.75;
                    tmp3.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp2.w, tmp3.w);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp2.w = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp2.x = dot(tmp2.xyz, tmp2.xyz);
                tmp4 = tex2D(_LightTexture0, tmp2.xx);
                tmp2.x = tmp2.w * tmp4.x;
                tmp4.x = dot(inp.texcoord1.xyz, tmp3.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp2.y = dot(tmp4.xyz, tmp4.xyz);
                tmp2.y = rsqrt(tmp2.y);
                tmp2.yzw = tmp2.yyy * tmp4.xyz;
                tmp3.xyz = tmp2.xxx * _LightColor0.xyz;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp1.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.x = dot(tmp2.xyz, tmp0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp0.y = _Specular * 128.0;
                tmp0.x = log(tmp0.x);
                tmp0.x = tmp0.x * tmp0.y;
                tmp0.x = exp(tmp0.x);
                tmp0.x = tmp1.w * tmp0.x;
                tmp0.yzw = tmp3.xyz * _SpecColor.xyz;
                o.sv_target.xyz = tmp0.xxx * tmp0.yzw;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "PREPASS"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend DstColor SrcColor, One One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 287172
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _Specular;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _BumpMap;
			
			// Keywords: GAMMA LDR
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord1.w = tmp0.x;
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp2.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp2.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp2.xyz;
                tmp2.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp2.xyz;
                tmp0.x = dot(tmp2.xyz, tmp2.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2.xyz = tmp0.xxx * tmp2.xyz;
                tmp3.xyz = tmp1.xyz * tmp2.xyz;
                tmp3.xyz = tmp1.zxy * tmp2.yzx + -tmp3.xyz;
                tmp0.x = v.tangent.w * unity_WorldTransformParams.w;
                tmp3.xyz = tmp0.xxx * tmp3.xyz;
                o.texcoord1.y = tmp3.x;
                o.texcoord1.x = tmp2.z;
                o.texcoord1.z = tmp1.y;
                o.texcoord2.x = tmp2.x;
                o.texcoord3.x = tmp2.y;
                o.texcoord2.z = tmp1.z;
                o.texcoord3.z = tmp1.x;
                o.texcoord2.w = tmp0.y;
                o.texcoord3.w = tmp0.z;
                o.texcoord2.y = tmp3.y;
                o.texcoord3.y = tmp3.z;
                return o;
			}
			// Keywords: GAMMA LDR
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp0.x = tmp0.w * tmp0.x;
                tmp0.xy = tmp0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp0.xy, tmp0.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.z = sqrt(tmp0.w);
                tmp1.x = dot(inp.texcoord1.xyz, tmp0.xyz);
                tmp1.y = dot(inp.texcoord2.xyz, tmp0.xyz);
                tmp1.z = dot(inp.texcoord3.xyz, tmp0.xyz);
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp0.xyz = tmp0.xxx * tmp1.xyz;
                o.sv_target.xyz = tmp0.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                o.sv_target.w = _Specular;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "PREPASS"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 381068
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _SpecColor;
			float _Glossness;
			float3 _SpecVals;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _LightBuffer;
			
			// Keywords: GAMMA LDR
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                tmp1 = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.position = tmp1;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord1.w = tmp0.x;
                tmp2.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp2.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp2.xyz;
                tmp2.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp2.xyz;
                tmp0.x = dot(tmp2.xyz, tmp2.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2.xyz = tmp0.xxx * tmp2.xyz;
                o.texcoord1.x = tmp2.z;
                tmp0.x = v.tangent.w * unity_WorldTransformParams.w;
                tmp3.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp3.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp3.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp4.xyz = tmp2.xyz * tmp3.zxy;
                tmp4.xyz = tmp3.yzx * tmp2.yzx + -tmp4.xyz;
                tmp4.xyz = tmp0.xxx * tmp4.xyz;
                o.texcoord1.y = tmp4.x;
                o.texcoord1.z = tmp3.x;
                o.texcoord2.x = tmp2.x;
                o.texcoord3.x = tmp2.y;
                o.texcoord2.w = tmp0.y;
                o.texcoord3.w = tmp0.z;
                o.texcoord2.y = tmp4.y;
                o.texcoord3.y = tmp4.z;
                o.texcoord2.z = tmp3.y;
                o.texcoord3.z = tmp3.z;
                tmp0.x = tmp1.y * _ProjectionParams.x;
                tmp0.w = tmp0.x * 0.5;
                tmp0.xz = tmp1.xw * float2(0.5, 0.5);
                o.texcoord4.zw = tmp1.zw;
                o.texcoord4.xy = tmp0.zz + tmp0.xw;
                o.texcoord5 = float4(0.0, 0.0, 0.0, 0.0);
                tmp0.x = tmp3.y * tmp3.y;
                tmp0.x = tmp3.x * tmp3.x + -tmp0.x;
                tmp1 = tmp3.yzzx * tmp3.xyzz;
                tmp2.x = dot(unity_SHBr, tmp1);
                tmp2.y = dot(unity_SHBg, tmp1);
                tmp2.z = dot(unity_SHBb, tmp1);
                tmp0.xyz = unity_SHC.xyz * tmp0.xxx + tmp2.xyz;
                tmp3.w = 1.0;
                tmp1.x = dot(unity_SHAr, tmp3);
                tmp1.y = dot(unity_SHAg, tmp3);
                tmp1.z = dot(unity_SHAb, tmp3);
                tmp0.xyz = tmp0.xyz + tmp1.xyz;
                tmp0.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                tmp0.xyz = log(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * float3(0.4166667, 0.4166667, 0.4166667);
                tmp0.xyz = exp(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * float3(1.055, 1.055, 1.055) + float3(-0.055, -0.055, -0.055);
                o.texcoord6.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                return o;
			}
			// Keywords: GAMMA LDR
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0.x = inp.texcoord1.w;
                tmp0.y = inp.texcoord2.w;
                tmp0.z = inp.texcoord3.w;
                tmp0.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1 = tex2D(_BumpMap, inp.texcoord.xy);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.xy = tmp1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp1.xy, tmp1.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp1.z = sqrt(tmp0.w);
                tmp2.x = dot(inp.texcoord1.xyz, tmp1.xyz);
                tmp2.y = dot(inp.texcoord2.xyz, tmp1.xyz);
                tmp2.z = dot(inp.texcoord3.xyz, tmp1.xyz);
                tmp0.w = dot(-tmp0.xyz, tmp2.xyz);
                tmp0.w = tmp0.w + tmp0.w;
                tmp2.xyz = tmp2.xyz * -tmp0.www + -tmp0.xyz;
                tmp2 = texCUBE(_Cube, tmp2.xyz);
                tmp3.xyz = tmp0.yyy * inp.texcoord2.xyz;
                tmp0.xyw = inp.texcoord1.xyz * tmp0.xxx + tmp3.xyz;
                tmp0.xyz = inp.texcoord3.xyz * tmp0.zzz + tmp0.xyw;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.x = dot(tmp0.xyz, tmp1.xyz);
                tmp0.x = 1.0 - tmp0.x;
                tmp0.x = tmp0.x * tmp0.x;
                tmp0.x = tmp0.x * _SpecVals.y;
                tmp0.x = tmp0.x * 0.5 + _SpecVals.x;
                tmp1 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0.y = tmp1.w * _Glossness;
                tmp0.x = tmp0.y * tmp0.x;
                tmp0.x = tmp0.x * 0.5;
                tmp0.yzw = tmp0.xxx * tmp2.xyz;
                tmp1.xy = inp.texcoord4.xy / inp.texcoord4.ww;
                tmp1 = tex2D(_LightBuffer, tmp1.xy);
                tmp1 = log(tmp1);
                tmp0.x = tmp0.x * -tmp1.w;
                tmp1.xyz = inp.texcoord6.xyz - tmp1.xyz;
                tmp1.xyz = tmp1.xyz * _SpecColor.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.xxx + tmp0.yzw;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
	}
}