// this code is from p0/Reflective/Bumped Specular SMap Baked
Shader "p0/Reflective/Bumped Specular SMap" {
	Properties {
		[MaterialEnum(Static, 0, Characters, 1, Hands, 2)] _StencilType ("_StencilType", Float) = 0
		_Color ("Main Color", Color) = (1,1,1,1)
		_BaseTintColor ("Tint Color", Color) = (1,1,1,1)
		_SpecMap ("GlossMap", 2D) = "white" {}
		_SpecColor ("Specular Color", Color) = (1,1,1,1)
		_Glossness ("Specularness", Range(0.01, 10)) = 1
		_Specularness ("Glossness", Range(0.01, 10)) = 1
		_ReflectColorMap ("Reflection Color Map", 2D) = "white" {}
		_MainTex ("Base (RGB) Specular (A)", 2D) = "white" {}
		[Toggle(TINTMASK)] _HasTint ("Has tint", Float) = 0
		_TintMask ("Tint mask", 2D) = "black" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_Cube2 ("Reflection Cubemap 2", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SpecVals ("Specular Vals", Vector) = (2,1,3,1)
		_DefVals ("Defuse Vals", Vector) = (1,0.4,1,0.4)
		_CutoutValue ("Cutout", Range(0, 1)) = 0.5
		_BumpTiling ("_BumpTiling", Float) = 1
		_NormalIntensity ("Normal intensity", Float) = 1
		_NormalUVMultiplier ("Normal UV tiling", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_DropsSpec ("Drops spec", Float) = 128
		_Temperature ("_Temperature", Vector) = (0.1,0.3,0.35,0)
		_Temperature2 ("_Temperature2", Vector) = (0.1,0.2,0.28,0)
		[Space(30)] [Header(Wetting)] _RippleTexScale ("_RippleTexScale", Float) = 4
		_RippleFakeLightIntensityOffset ("Ripple fake light offset", Float) = 0.7
		_NightRippleFakeLightOffset ("Night fake light offset", Float) = 0.2
		_NdotLOffset ("Normal dot light offset", Float) = 0.4
		[Toggle(USERAIN)] _USERAIN ("Is material affected by rain", Float) = 0
		[HideInInspector] _SkinnedMeshMaterial ("Skinned Mesh Material", Float) = 0
		[Toggle(USEHEAT)] USEHEAT ("Use metal heat glow", Float) = 0
		_HeatVisible ("_HeatVisible([0-1] for thermalVision only)", Float) = 1
		[HDR] _HeatColor1 ("_HeatColor1", Color) = (1,0,0,1)
		[HDR] _HeatColor2 ("_HeatColor2", Color) = (1,0.34,0,1)
		_HeatCenter ("_HeatCenter", Vector) = (0,0,0,1)
		_HeatSize ("_HeatSize", Vector) = (0.02,0.04,0.02,1)
		_HeatTemp ("_HeatTemp", Float) = 0
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			ColorMask RGB
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 31141
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
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord8 : TEXCOORD8;
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
			float4 _Color;
			float _Specularness;
			float _Glossness;
			float _NormalIntensity;
			float _NormalUVMultiplier;
			float4 _SpecVals;
			float4 _DefVals;
			float _BumpTiling;
			float4 _Temperature;
			float4 _Temperature2;
			float _ThermalVisionOn;
			float _HeatThermalFactor;
			float _CutoutValue;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _ReflectColorMap;
			samplerCUBE _Cube2;
			samplerCUBE _Cube;
			
			// Keywords: DIRECTIONAL
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
                o.texcoord4.xyz = v.normal.xyz;
                o.texcoord5.xyz = v.vertex.xyz;
                tmp0.x = tmp2.y * tmp2.y;
                tmp0.x = tmp2.x * tmp2.x + -tmp0.x;
                tmp1 = tmp2.ywzx * tmp2;
                tmp2.x = dot(unity_SHBr, tmp1);
                tmp2.y = dot(unity_SHBg, tmp1);
                tmp2.z = dot(unity_SHBb, tmp1);
                o.texcoord6.xyz = unity_SHC.xyz * tmp0.xxx + tmp2.xyz;
                o.texcoord8 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: DIRECTIONAL
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
                float4 tmp7;
                float4 tmp8;
                float4 tmp9;
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
                tmp5 = tex2D(_SpecMap, inp.texcoord.xy);
                tmp5.yz = inp.texcoord.xy * _BumpTiling.xx;
                tmp6 = tex2D(_BumpMap, tmp5.yz);
                tmp6.yzw = tmp6.xyw * _NormalUVMultiplier.xxx;
                tmp6.x = tmp6.w * tmp6.y;
                tmp5.yz = tmp6.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp1.w = dot(tmp5.xy, tmp5.xy);
                tmp1.w = min(tmp1.w, 1.0);
                tmp1.w = 1.0 - tmp1.w;
                tmp6.z = sqrt(tmp1.w);
                tmp7 = tex2D(_ReflectColorMap, inp.texcoord.xy);
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp4.w * _Glossness;
                tmp2.w = tmp5.x * _Specularness;
                tmp6.xy = tmp5.yz * _NormalIntensity.xx;
                tmp5.x = dot(inp.texcoord1.xyz, tmp6.xyz);
                tmp5.y = dot(inp.texcoord2.xyz, tmp6.xyz);
                tmp5.z = dot(inp.texcoord3.xyz, tmp6.xyz);
                tmp3.w = dot(-tmp2.xyz, tmp5.xyz);
                tmp3.w = tmp3.w + tmp3.w;
                tmp2.xyz = tmp5.xyz * -tmp3.www + -tmp2.xyz;
                tmp8 = texCUBE(_Cube2, tmp2.xyz);
                tmp9 = texCUBE(_Cube, tmp2.xyz);
                tmp2.xyz = tmp9.xyz - tmp8.xyz;
                tmp2.xyz = tmp7.www * tmp2.xyz + tmp8.xyz;
                tmp2.xyz = tmp4.www * tmp2.xyz;
                tmp2.xyz = tmp7.xyz * tmp2.xyz;
                tmp3.w = dot(tmp3.xyz, tmp3.xyz);
                tmp3.w = rsqrt(tmp3.w);
                tmp3.xyz = tmp3.www * tmp3.xyz;
                tmp3.x = dot(tmp3.xyz, tmp6.xyz);
                tmp3.x = 1.0 - tmp3.x;
                tmp3.x = tmp3.x * tmp3.x;
                tmp3.x = tmp3.x * 0.5;
                tmp3.yz = _SpecVals.xy - _SpecVals.zw;
                tmp3.yz = tmp7.ww * tmp3.yz + _SpecVals.zw;
                tmp6.xy = _DefVals.xy - _DefVals.zw;
                tmp6.xy = tmp7.ww * tmp6.xy + _DefVals.zw;
                tmp3.y = tmp3.z * tmp3.x + tmp3.y;
                tmp3.y = tmp3.y * 0.5;
                tmp3.x = tmp6.y * tmp3.x + tmp6.x;
                tmp3.xzw = tmp3.xxx * tmp4.xyz;
                tmp1.w = tmp1.w * tmp3.y;
                tmp4 = _Temperature - _Temperature2;
                tmp4 = tmp7.wwww * tmp4 + _Temperature2;
                tmp6.xyz = tmp3.xzw * tmp4.zzz;
                tmp4.z = _ThermalVisionOn > 0.0;
                tmp4.x = tmp4.x * _HeatThermalFactor;
                tmp6.xyz = max(tmp4.xxx, tmp6.xyz);
                tmp6.xyz = min(tmp4.yyy, tmp6.xyz);
                tmp4.xyw = tmp4.www + tmp6.xyz;
                tmp3.xzw = tmp4.zzz ? tmp4.xyw : tmp3.xzw;
                tmp4.x = tmp5.w - _CutoutValue;
                tmp4.x = tmp4.x < 0.0;
                if (tmp4.x) {
                    discard;
                }
                tmp4.x = unity_ProbeVolumeParams.x == 1.0;
                if (tmp4.x) {
                    tmp4.y = unity_ProbeVolumeParams.y == 1.0;
                    tmp6.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp6.xyz;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp6.xyz;
                    tmp6.xyz = tmp6.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp4.yzw = tmp4.yyy ? tmp6.xyz : tmp0.yzw;
                    tmp4.yzw = tmp4.yzw - unity_ProbeVolumeMin;
                    tmp6.yzw = tmp4.yzw * unity_ProbeVolumeSizeInv;
                    tmp4.y = tmp6.y * 0.25 + 0.75;
                    tmp4.z = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp6.x = max(tmp4.z, tmp4.y);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp6.xzw);
                } else {
                    tmp6 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp4.y = saturate(dot(tmp6, unity_OcclusionMaskSelector));
                tmp4.z = dot(tmp5.xyz, tmp5.xyz);
                tmp4.z = rsqrt(tmp4.z);
                tmp6.xyz = tmp4.zzz * tmp5.xyz;
                tmp4.yzw = tmp4.yyy * _LightColor0.xyz;
                if (tmp4.x) {
                    tmp4.x = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp4.xxx ? tmp5.xyz : tmp0.yzw;
                    tmp0.yzw = tmp0.yzw - unity_ProbeVolumeMin;
                    tmp7.yzw = tmp0.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp7.y * 0.25;
                    tmp0.z = unity_ProbeVolumeParams.z * 0.5;
                    tmp0.w = -unity_ProbeVolumeParams.z * 0.5 + 0.25;
                    tmp0.y = max(tmp0.z, tmp0.y);
                    tmp7.x = min(tmp0.w, tmp0.y);
                    tmp8 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp7.xzw);
                    tmp0.yzw = tmp7.xzw + float3(0.25, 0.0, 0.0);
                    tmp9 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.yzw);
                    tmp0.yzw = tmp7.xzw + float3(0.5, 0.0, 0.0);
                    tmp7 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.yzw);
                    tmp6.w = 1.0;
                    tmp5.x = dot(tmp8, tmp6);
                    tmp5.y = dot(tmp9, tmp6);
                    tmp5.z = dot(tmp7, tmp6);
                } else {
                    tmp6.w = 1.0;
                    tmp5.x = dot(unity_SHAr, tmp6);
                    tmp5.y = dot(unity_SHAg, tmp6);
                    tmp5.z = dot(unity_SHAb, tmp6);
                }
                tmp0.yzw = tmp5.xyz + inp.texcoord6.xyz;
                tmp0.yzw = max(tmp0.yzw, float3(0.0, 0.0, 0.0));
                tmp0.yzw = log(tmp0.yzw);
                tmp0.yzw = tmp0.yzw * float3(0.4166667, 0.4166667, 0.4166667);
                tmp0.yzw = exp(tmp0.yzw);
                tmp0.yzw = tmp0.yzw * float3(1.055, 1.055, 1.055) + float3(-0.055, -0.055, -0.055);
                tmp0.yzw = max(tmp0.yzw, float3(0.0, 0.0, 0.0));
                tmp1.xyz = tmp1.xyz * tmp0.xxx + _WorldSpaceLightPos0.xyz;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(tmp6.xyz, _WorldSpaceLightPos0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp1.x = dot(tmp6.xyz, tmp1.xyz);
                tmp1.x = max(tmp1.x, 0.0);
                tmp1.y = tmp2.w * 128.0;
                tmp1.x = log(tmp1.x);
                tmp1.x = tmp1.x * tmp1.y;
                tmp1.x = exp(tmp1.x);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.yzw = tmp3.xzw * tmp4.yzw;
                tmp4.xyz = tmp4.yzw * _SpecColor.xyz;
                tmp4.xyz = tmp1.xxx * tmp4.xyz;
                tmp1.xyz = tmp1.yzw * tmp0.xxx + tmp4.xyz;
                tmp0.xyz = tmp3.xzw * tmp0.yzw + tmp1.xyz;
                o.sv_target.xyz = tmp2.xyz * tmp3.yyy + tmp0.xyz;
                o.sv_target.w = tmp5.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Blend One One, One One
			ColorMask RGB
			ZWrite Off
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 84593
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
				float3 texcoord6 : TEXCOORD6;
				float3 texcoord7 : TEXCOORD7;
				float4 texcoord8 : TEXCOORD8;
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
			float4 _Color;
			float _Specularness;
			float _Glossness;
			float _NormalIntensity;
			float _NormalUVMultiplier;
			float4 _SpecVals;
			float4 _DefVals;
			float _BumpTiling;
			float4 _Temperature;
			float4 _Temperature2;
			float _ThermalVisionOn;
			float _HeatThermalFactor;
			float _CutoutValue;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _ReflectColorMap;
			sampler2D _LightTexture0;
			
			// Keywords: POINT
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
                o.texcoord5.xyz = v.normal.xyz;
                o.texcoord6.xyz = v.vertex.xyz;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord7.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                o.texcoord8 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: POINT
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
                float4 tmp7;
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord4.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp0.xyz;
                tmp2.xyz = _WorldSpaceCameraPos - inp.texcoord4.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3.xyz = tmp2.yyy * inp.texcoord2.xyz;
                tmp3.xyz = inp.texcoord1.xyz * tmp2.xxx + tmp3.xyz;
                tmp3.xyz = inp.texcoord3.xyz * tmp2.zzz + tmp3.xyz;
                tmp4 = tex2D(_MainTex, inp.texcoord.xy);
                tmp5 = tex2D(_SpecMap, inp.texcoord.xy);
                tmp5.yz = inp.texcoord.xy * _BumpTiling.xx;
                tmp6 = tex2D(_BumpMap, tmp5.yz);
                tmp6.yzw = tmp6.xyw * _NormalUVMultiplier.xxx;
                tmp6.x = tmp6.w * tmp6.y;
                tmp5.yz = tmp6.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp1.w = dot(tmp5.xy, tmp5.xy);
                tmp1.w = min(tmp1.w, 1.0);
                tmp1.w = 1.0 - tmp1.w;
                tmp6.z = sqrt(tmp1.w);
                tmp7 = tex2D(_ReflectColorMap, inp.texcoord.xy);
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp4.w * _Glossness;
                tmp2.w = tmp5.x * _Specularness;
                tmp6.xy = tmp5.yz * _NormalIntensity.xx;
                tmp3.w = dot(tmp3.xyz, tmp3.xyz);
                tmp3.w = rsqrt(tmp3.w);
                tmp3.xyz = tmp3.www * tmp3.xyz;
                tmp3.x = dot(tmp3.xyz, tmp6.xyz);
                tmp3.x = 1.0 - tmp3.x;
                tmp3.x = tmp3.x * tmp3.x;
                tmp3.x = tmp3.x * 0.5;
                tmp3.yz = _SpecVals.xy - _SpecVals.zw;
                tmp3.yz = tmp7.ww * tmp3.yz + _SpecVals.zw;
                tmp5.xy = _DefVals.xy - _DefVals.zw;
                tmp5.xy = tmp7.ww * tmp5.xy + _DefVals.zw;
                tmp3.y = tmp3.z * tmp3.x + tmp3.y;
                tmp3.y = tmp3.y * 0.5;
                tmp3.x = tmp5.y * tmp3.x + tmp5.x;
                tmp3.xzw = tmp3.xxx * tmp4.xyz;
                tmp1.w = tmp1.w * tmp3.y;
                tmp4 = _Temperature - _Temperature2;
                tmp4 = tmp7.wwww * tmp4 + _Temperature2;
                tmp5.xyz = tmp3.xzw * tmp4.zzz;
                tmp3.y = _ThermalVisionOn > 0.0;
                tmp4.x = tmp4.x * _HeatThermalFactor;
                tmp5.xyz = max(tmp4.xxx, tmp5.xyz);
                tmp4.xyz = min(tmp4.yyy, tmp5.xyz);
                tmp4.xyz = tmp4.www + tmp4.xyz;
                tmp3.xyz = tmp3.yyy ? tmp4.xyz : tmp3.xzw;
                tmp3.w = tmp5.w - _CutoutValue;
                tmp3.w = tmp3.w < 0.0;
                if (tmp3.w) {
                    discard;
                }
                tmp4.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp4.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp4.xyz;
                tmp4.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp4.xyz;
                tmp4.xyz = tmp4.xyz + unity_WorldToLight._m03_m13_m23;
                tmp3.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp3.w) {
                    tmp3.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord4.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord4.xxx + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.zzz + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp5.xyz = tmp3.www ? tmp5.xyz : inp.texcoord4.xyz;
                    tmp5.xyz = tmp5.xyz - unity_ProbeVolumeMin;
                    tmp7.yzw = tmp5.xyz * unity_ProbeVolumeSizeInv;
                    tmp3.w = tmp7.y * 0.25 + 0.75;
                    tmp4.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp7.x = max(tmp3.w, tmp4.w);
                    tmp7 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp7.xzw);
                } else {
                    tmp7 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp3.w = saturate(dot(tmp7, unity_OcclusionMaskSelector));
                tmp4.x = dot(tmp4.xyz, tmp4.xyz);
                tmp4 = tex2D(_LightTexture0, tmp4.xx);
                tmp3.w = tmp3.w * tmp4.x;
                tmp4.x = dot(inp.texcoord1.xyz, tmp6.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp6.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp6.xyz);
                tmp4.w = dot(tmp4.xyz, tmp4.xyz);
                tmp4.w = rsqrt(tmp4.w);
                tmp4.xyz = tmp4.www * tmp4.xyz;
                tmp5.xyz = tmp3.www * _LightColor0.xyz;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(tmp4.xyz, tmp1.xyz);
                tmp0.x = dot(tmp4.xyz, tmp0.xyz);
                tmp0.xw = max(tmp0.xw, float2(0.0, 0.0));
                tmp0.y = tmp2.w * 128.0;
                tmp0.x = log(tmp0.x);
                tmp0.x = tmp0.x * tmp0.y;
                tmp0.x = exp(tmp0.x);
                tmp0.x = tmp1.w * tmp0.x;
                tmp1.xyz = tmp3.xyz * tmp5.xyz;
                tmp2.xyz = tmp5.xyz * _SpecColor.xyz;
                tmp0.xyz = tmp0.xxx * tmp2.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.www + tmp0.xyz;
                o.sv_target.w = tmp5.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 169569
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
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord7 : TEXCOORD7;
				float3 texcoord8 : TEXCOORD8;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _SpecColor;
			float4 _Color;
			float _Specularness;
			float _Glossness;
			float _NormalIntensity;
			float _NormalUVMultiplier;
			float4 _SpecVals;
			float4 _DefVals;
			float _BumpTiling;
			float4 _Temperature;
			float4 _Temperature2;
			float _ThermalVisionOn;
			float _HeatThermalFactor;
			float _CutoutValue;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecMap;
			sampler2D _BumpMap;
			sampler2D _ReflectColorMap;
			samplerCUBE _Cube2;
			samplerCUBE _Cube;
			
			// Keywords: 
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
                tmp1.xyz = v.tangent.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp1.xyz = unity_ObjectToWorld._m00_m10_m20 * v.tangent.xxx + tmp1.xyz;
                tmp1.xyz = unity_ObjectToWorld._m02_m12_m22 * v.tangent.zzz + tmp1.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                o.texcoord1.x = tmp1.x;
                tmp0.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2 = tmp1.wwww * tmp2.xyzz;
                tmp3.xyz = tmp1.yzx * tmp2.wxy;
                tmp3.xyz = tmp2.ywx * tmp1.zxy + -tmp3.xyz;
                tmp3.xyz = tmp0.www * tmp3.xyz;
                o.texcoord1.y = tmp3.x;
                o.texcoord1.z = tmp2.x;
                o.texcoord2.x = tmp1.y;
                o.texcoord2.w = tmp0.y;
                o.texcoord2.y = tmp3.y;
                o.texcoord2.z = tmp2.y;
                o.texcoord3.x = tmp1.z;
                o.texcoord3.w = tmp0.z;
                tmp0.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                o.texcoord3.y = tmp3.z;
                o.texcoord6.y = dot(tmp0.xyz, tmp3.xyz);
                o.texcoord3.z = tmp2.w;
                o.texcoord4.xyz = v.normal.xyz;
                o.texcoord5.xyz = v.vertex.xyz;
                o.texcoord6.x = dot(tmp0.xyz, tmp1.xyz);
                o.texcoord6.z = dot(tmp0.xyz, tmp2.xyz);
                o.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
                tmp0.x = tmp2.y * tmp2.y;
                tmp0.x = tmp2.x * tmp2.x + -tmp0.x;
                tmp1 = tmp2.ywzx * tmp2;
                tmp2.x = dot(unity_SHBr, tmp1);
                tmp2.y = dot(unity_SHBg, tmp1);
                tmp2.z = dot(unity_SHBb, tmp1);
                o.texcoord8.xyz = unity_SHC.xyz * tmp0.xxx + tmp2.xyz;
                return o;
			}
			// Keywords: 
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
                float4 tmp7;
                tmp0.y = inp.texcoord1.w;
                tmp0.z = inp.texcoord2.w;
                tmp0.w = inp.texcoord3.w;
                tmp1.xyz = _WorldSpaceCameraPos - tmp0.yzw;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(inp.texcoord6.xyz, inp.texcoord6.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2.xyz = tmp0.xxx * inp.texcoord6.xyz;
                tmp3 = tex2D(_MainTex, inp.texcoord.xy);
                tmp4 = tex2D(_SpecMap, inp.texcoord.xy);
                tmp4.yz = inp.texcoord.xy * _BumpTiling.xx;
                tmp5 = tex2D(_BumpMap, tmp4.yz);
                tmp5.yzw = tmp5.xyw * _NormalUVMultiplier.xxx;
                tmp5.x = tmp5.w * tmp5.y;
                tmp4.yz = tmp5.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.x = dot(tmp4.xy, tmp4.xy);
                tmp0.x = min(tmp0.x, 1.0);
                tmp0.x = 1.0 - tmp0.x;
                tmp5.z = sqrt(tmp0.x);
                tmp6 = tex2D(_ReflectColorMap, inp.texcoord.xy);
                tmp3.xyz = tmp3.xyz * _Color.xyz;
                tmp0.x = tmp3.w * _Glossness;
                o.sv_target1.w = tmp4.x * _Specularness;
                tmp5.xy = tmp4.yz * _NormalIntensity.xx;
                tmp4.x = dot(inp.texcoord1.xyz, tmp5.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp5.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp5.xyz);
                tmp1.w = dot(-tmp1.xyz, tmp4.xyz);
                tmp1.w = tmp1.w + tmp1.w;
                tmp1.xyz = tmp4.xyz * -tmp1.www + -tmp1.xyz;
                tmp7 = texCUBE(_Cube2, tmp1.xyz);
                tmp1 = texCUBE(_Cube, tmp1.xyz);
                tmp1.xyz = tmp1.xyz - tmp7.xyz;
                tmp1.xyz = tmp6.www * tmp1.xyz + tmp7.xyz;
                tmp1.xyz = tmp3.www * tmp1.xyz;
                tmp1.xyz = tmp6.xyz * tmp1.xyz;
                tmp1.w = dot(tmp2.xyz, tmp5.xyz);
                tmp1.w = 1.0 - tmp1.w;
                tmp1.w = tmp1.w * tmp1.w;
                tmp1.w = tmp1.w * 0.5;
                tmp2.xy = _SpecVals.xy - _SpecVals.zw;
                tmp2.xy = tmp6.ww * tmp2.xy + _SpecVals.zw;
                tmp2.zw = _DefVals.xy - _DefVals.zw;
                tmp2.zw = tmp6.ww * tmp2.zw + _DefVals.zw;
                tmp2.x = tmp2.y * tmp1.w + tmp2.x;
                tmp2.x = tmp2.x * 0.5;
                tmp1.w = tmp2.w * tmp1.w + tmp2.z;
                tmp2.yzw = tmp1.www * tmp3.xyz;
                tmp0.x = tmp0.x * tmp2.x;
                tmp3 = _Temperature - _Temperature2;
                tmp3 = tmp6.wwww * tmp3 + _Temperature2;
                tmp5.xyz = tmp2.yzw * tmp3.zzz;
                tmp1.w = _ThermalVisionOn > 0.0;
                tmp3.x = tmp3.x * _HeatThermalFactor;
                tmp5.xyz = max(tmp3.xxx, tmp5.xyz);
                tmp3.xyz = min(tmp3.yyy, tmp5.xyz);
                tmp3.xyz = tmp3.www + tmp3.xyz;
                tmp2.yzw = tmp1.www ? tmp3.xyz : tmp2.yzw;
                tmp1.w = tmp4.w - _CutoutValue;
                tmp1.w = tmp1.w < 0.0;
                if (tmp1.w) {
                    discard;
                }
                tmp1.w = dot(tmp4.xyz, tmp4.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp3.xyz = tmp1.www * tmp4.xyz;
                tmp1.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp1.w) {
                    tmp1.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp1.www ? tmp4.xyz : tmp0.yzw;
                    tmp0.yzw = tmp0.yzw - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp0.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp4.y * 0.25;
                    tmp0.z = unity_ProbeVolumeParams.z * 0.5;
                    tmp0.w = -unity_ProbeVolumeParams.z * 0.5 + 0.25;
                    tmp0.y = max(tmp0.z, tmp0.y);
                    tmp4.x = min(tmp0.w, tmp0.y);
                    tmp5 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                    tmp0.yzw = tmp4.xzw + float3(0.25, 0.0, 0.0);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.yzw);
                    tmp0.yzw = tmp4.xzw + float3(0.5, 0.0, 0.0);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp0.yzw);
                    tmp3.w = 1.0;
                    tmp5.x = dot(tmp5, tmp3);
                    tmp5.y = dot(tmp6, tmp3);
                    tmp5.z = dot(tmp4, tmp3);
                } else {
                    tmp3.w = 1.0;
                    tmp5.x = dot(unity_SHAr, tmp3);
                    tmp5.y = dot(unity_SHAg, tmp3);
                    tmp5.z = dot(unity_SHAb, tmp3);
                }
                tmp0.yzw = tmp5.xyz + inp.texcoord8.xyz;
                tmp0.yzw = max(tmp0.yzw, float3(0.0, 0.0, 0.0));
                tmp0.yzw = log(tmp0.yzw);
                tmp0.yzw = tmp0.yzw * float3(0.4166667, 0.4166667, 0.4166667);
                tmp0.yzw = exp(tmp0.yzw);
                tmp0.yzw = tmp0.yzw * float3(1.055, 1.055, 1.055) + float3(-0.055, -0.055, -0.055);
                tmp0.yzw = max(tmp0.yzw, float3(0.0, 0.0, 0.0));
                o.sv_target1.xyz = tmp0.xxx * _SpecColor.xyz;
                o.sv_target2.xyz = tmp3.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                tmp0.xyz = tmp0.yzw * tmp2.yzw;
                tmp0.xyz = tmp1.xyz * tmp2.xxx + tmp0.xyz;
                o.sv_target3.xyz = exp(-tmp0.xyz);
                o.sv_target.xyz = tmp2.yzw;
                o.sv_target.w = 1.0;
                o.sv_target2.w = 1.0;
                o.sv_target3.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			ColorMask 0
			ZClip Off
			Cull Front
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 260257
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
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
			
			// Keywords: SHADOWS_DEPTH
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp1 = tmp0.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp1 = unity_MatrixVP._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp1 = unity_MatrixVP._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp0 = unity_MatrixVP._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                tmp1.x = unity_LightShadowBias.x / tmp0.w;
                tmp1.x = min(tmp1.x, 0.0);
                tmp1.x = max(tmp1.x, -1.0);
                tmp0.z = tmp0.z + tmp1.x;
                tmp1.x = min(tmp0.w, tmp0.z);
                o.position.xyw = tmp0.xyw;
                tmp0.x = tmp1.x - tmp0.z;
                o.position.z = unity_LightShadowBias.y * tmp0.x + tmp0.z;
                return o;
			}
			// Keywords: SHADOWS_DEPTH
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
	}
	Fallback "Reflective/Bumped Diffuse"
	CustomEditor "FresnelMaterialEditor"
}