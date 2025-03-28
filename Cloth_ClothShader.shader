Shader "Cloth/ClothShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_GlossMap ("Gloss map", 2D) = "white" {}
		_NoiseTex ("Vertex Noise texture", 2D) = "grey" {}
		_NormalMap1 ("NormalMap", 2D) = "bump1" {}
		_NormalMap2 ("NormalMap", 2D) = "bump2" {}
		_NormalsMask ("Normals Mask", 2D) = "normalmask" {}
		_CutoutMask ("Cutout Mask", 2D) = "cutoutmask" {}
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0
		_ScrollXSpeed ("X Scroll Speed", Range(-1, 1)) = 0.1
		_ScrollYSpeed ("Y Scroll Speed", Range(-1, 1)) = 0.1
		_ScrollSpeedRandomFactor ("Scroll Speed Random Factor", Float) = 1
		_NormalBlendingRandomFactor ("Normal blending factor", Float) = 1
		_VertexTimeOffset ("VertexOffset", Float) = 1
		_NormalBlendThreshold ("Normal blend threshold", Float) = 1
		_VertexAnimationScale ("Vertex animation strength", Float) = 0
		_VertexAnimationSpeedMultiplier ("Vertex animation speed", Float) = 1
		_CutOff ("Cut off", Range(0, 1)) = 0
		[Space(30)] _Temperature ("_Temperature", Vector) = (0.1,0.2,0.28,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 53773
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float _VertexTimeOffset;
			float _VertexAnimationScale;
			float _VertexAnimationSpeedMultiplier;
			float4 _MainTex_ST;
			float4 _NormalMap1_ST;
			float4 _NormalMap2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float _ScrollXSpeed;
			float _ScrollYSpeed;
			float _ScrollSpeedRandomFactor;
			float _NormalBlendThreshold;
			float _NormalBlendingRandomFactor;
			float _CutOff;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			sampler2D _NoiseTex;
			sampler2D _NormalsMask;
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _CutoutMask;
			sampler2D _GlossMap;
			sampler2D _NormalMap1;
			sampler2D _NormalMap2;
			sampler2D unity_NHxRoughness;
			
			// Keywords: DIRECTIONAL
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = tex2Dlod(_NoiseTex, float4(v.texcoord.xy, 0, 0.0));
                tmp0.x = tmp0.x * 100.0;
                tmp0.y = _VertexTimeOffset * _Time.x;
                tmp0.x = tmp0.y * _VertexAnimationSpeedMultiplier + tmp0.x;
                tmp0.x = sin(tmp0.x);
                tmp0.xyz = tmp0.xxx * v.normal.xyz;
                tmp0.xyz = tmp0.xyz * _VertexAnimationScale.xxx;
                tmp1 = tex2Dlod(_NormalsMask, float4(v.texcoord.xy, 0, 0.0));
                tmp0.xyz = tmp0.xyz * tmp1.xxx + v.vertex.xyz;
                tmp1 = tmp0.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp1 = unity_ObjectToWorld._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
                o.texcoord2.w = tmp0.x;
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
                o.texcoord2.y = tmp3.x;
                o.texcoord2.x = tmp2.z;
                o.texcoord2.z = tmp1.y;
                o.texcoord3.w = tmp0.y;
                o.texcoord4.w = tmp0.z;
                o.texcoord3.x = tmp2.x;
                o.texcoord4.x = tmp2.y;
                o.texcoord3.z = tmp1.z;
                o.texcoord4.z = tmp1.x;
                o.texcoord3.y = tmp3.y;
                o.texcoord4.y = tmp3.z;
                o.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
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
                tmp0 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0 = tmp0 * _Color;
                tmp1 = tex2Dlod(_CutoutMask, float4(inp.texcoord.xy, 0, 0.0));
                tmp1.x = 1.0 - tmp1.x;
                tmp1.x = tmp1.x * _CutOff;
                tmp0.w = tmp0.w < tmp1.x;
                if (tmp0.w) {
                    discard;
                }
                tmp1.y = inp.texcoord2.w;
                tmp1.z = inp.texcoord3.w;
                tmp1.w = inp.texcoord4.w;
                tmp2.xyz = _WorldSpaceCameraPos - tmp1.yzw;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp0.w = tmp2.y * inp.texcoord3.z;
                tmp0.w = inp.texcoord2.z * tmp2.x + tmp0.w;
                tmp0.w = inp.texcoord4.z * tmp2.z + tmp0.w;
                tmp3.xyz = float3(_ScrollXSpeed.x, _ScrollYSpeed.x, _ScrollSpeedRandomFactor.x) * _Time.yxy;
                tmp4.yz = frac(tmp3.xz);
                tmp1.x = cos(tmp3.y);
                tmp4.x = tmp1.x * 0.1 + tmp4.y;
                tmp3.xy = tmp4.xz + inp.texcoord1.xy;
                tmp4 = tex2D(_GlossMap, inp.texcoord.xy);
                tmp1.x = tmp4.x * _Metallic;
                tmp4 = tex2D(_NormalMap1, inp.texcoord.zw);
                tmp4.x = tmp4.w * tmp4.x;
                tmp4.xy = tmp4.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp4.xy, tmp4.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp4.z = sqrt(tmp2.w);
                tmp3 = tex2D(_NormalMap2, tmp3.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp3.xy, tmp3.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp3.z = sqrt(tmp2.w);
                tmp2.w = _NormalBlendingRandomFactor * _Time.x;
                tmp2.w = cos(tmp2.w);
                tmp2.w = tmp2.w * 0.4;
                tmp3.xyz = tmp3.xyz * _NormalBlendThreshold.xxx;
                tmp3.xyz = tmp3.xyz * tmp2.www + tmp4.xyz;
                tmp5 = tex2D(_NormalsMask, inp.texcoord.xy);
                tmp0.w = tmp0.w > 0.0;
                tmp4.xyz = tmp0.www ? tmp4.xyz : -tmp4.xyz;
                tmp3.xyz = tmp0.www ? tmp3.xyz : -tmp3.xyz;
                tmp3.xyz = tmp3.xyz - tmp4.xyz;
                tmp3.xyz = tmp5.xxx * tmp3.xyz + tmp4.xyz;
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = _ThermalVisionOn > 0.0;
                tmp4.xyz = tmp0.xyz * _Temperature.zzz;
                tmp4.xyz = max(tmp4.xyz, _Temperature.xxx);
                tmp4.xyz = min(tmp4.xyz, _Temperature.yyy);
                tmp4.xyz = tmp4.xyz + _Temperature.www;
                tmp0.xyz = tmp0.www ? tmp4.xyz : tmp0.xyz;
                tmp0.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp0.w) {
                    tmp0.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord3.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.www + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.www + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp1.yzw = tmp0.www ? tmp4.xyz : tmp1.yzw;
                    tmp1.yzw = tmp1.yzw - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp1.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.w = tmp4.y * 0.25 + 0.75;
                    tmp1.y = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp0.w, tmp1.y);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.w = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp4.x = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp4.y = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp4.z = dot(inp.texcoord4.xyz, tmp3.xyz);
                tmp1.y = dot(tmp4.xyz, tmp4.xyz);
                tmp1.y = rsqrt(tmp1.y);
                tmp1.yzw = tmp1.yyy * tmp4.xyz;
                tmp3.xw = float2(1.0, 1.0) - _Glossiness.xx;
                tmp2.w = dot(-tmp2.xyz, tmp1.xyz);
                tmp2.w = tmp2.w + tmp2.w;
                tmp4.xyz = tmp1.yzw * -tmp2.www + -tmp2.xyz;
                tmp5.xyz = tmp0.www * _LightColor0.xyz;
                tmp0.w = -tmp3.x * 0.7 + 1.7;
                tmp0.w = tmp0.w * tmp3.x;
                tmp0.w = tmp0.w * 6.0;
                tmp4 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp4.xyz, tmp0.w));
                tmp0.w = tmp4.w - 1.0;
                tmp0.w = unity_SpecCube0_HDR.w * tmp0.w + 1.0;
                tmp0.w = tmp0.w * unity_SpecCube0_HDR.x;
                tmp4.xyz = tmp4.xyz * tmp0.www;
                tmp6.xyz = tmp0.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                tmp6.xyz = tmp1.xxx * tmp6.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp0.w = -tmp1.x * 0.7790837 + 0.7790837;
                tmp1.x = dot(tmp2.xyz, tmp1.xyz);
                tmp2.w = tmp1.x + tmp1.x;
                tmp2.xyz = tmp1.yzw * -tmp2.www + tmp2.xyz;
                tmp1.y = saturate(dot(tmp1.xyz, _WorldSpaceLightPos0.xyz));
                tmp1.x = saturate(tmp1.x);
                tmp2.x = dot(tmp2.xyz, _WorldSpaceLightPos0.xyz);
                tmp2.y = 1.0 - tmp1.x;
                tmp2.zw = tmp2.xy * tmp2.xy;
                tmp1.xz = tmp2.xy * tmp2.xw;
                tmp3.yz = tmp2.zy * tmp1.xz;
                tmp1.x = _Glossiness - tmp0.w;
                tmp1.x = saturate(tmp1.x + 1.0);
                tmp2 = tex2D(unity_NHxRoughness, tmp3.yw);
                tmp1.z = tmp2.x * 16.0;
                tmp2.xyz = tmp6.xyz * tmp1.zzz;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp2.xyz;
                tmp1.yzw = tmp1.yyy * tmp5.xyz;
                tmp2.xyz = tmp1.xxx - tmp6.xyz;
                tmp2.xyz = tmp3.zzz * tmp2.xyz + tmp6.xyz;
                tmp2.xyz = tmp2.xyz * tmp4.xyz;
                o.sv_target.xyz = tmp0.xyz * tmp1.yzw + tmp2.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 95713
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 unity_WorldToLight;
			float _VertexTimeOffset;
			float _VertexAnimationScale;
			float _VertexAnimationSpeedMultiplier;
			float4 _MainTex_ST;
			float4 _NormalMap1_ST;
			float4 _NormalMap2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float _ScrollXSpeed;
			float _ScrollYSpeed;
			float _ScrollSpeedRandomFactor;
			float _NormalBlendThreshold;
			float _NormalBlendingRandomFactor;
			float _CutOff;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			sampler2D _NoiseTex;
			sampler2D _NormalsMask;
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _CutoutMask;
			sampler2D _GlossMap;
			sampler2D _NormalMap1;
			sampler2D _NormalMap2;
			sampler2D _LightTexture0;
			sampler2D unity_NHxRoughness;
			
			// Keywords: POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0 = tex2Dlod(_NoiseTex, float4(v.texcoord.xy, 0, 0.0));
                tmp0.x = tmp0.x * 100.0;
                tmp0.y = _VertexTimeOffset * _Time.x;
                tmp0.x = tmp0.y * _VertexAnimationSpeedMultiplier + tmp0.x;
                tmp0.x = sin(tmp0.x);
                tmp0.xyz = tmp0.xxx * v.normal.xyz;
                tmp0.xyz = tmp0.xyz * _VertexAnimationScale.xxx;
                tmp1 = tex2Dlod(_NormalsMask, float4(v.texcoord.xy, 0, 0.0));
                tmp0.xyz = tmp0.xyz * tmp1.xxx + v.vertex.xyz;
                tmp1 = tmp0.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp1 = unity_ObjectToWorld._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
                tmp1.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.texcoord2.w = tmp1.x;
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp1.x = dot(tmp2.xyz, tmp2.xyz);
                tmp1.x = rsqrt(tmp1.x);
                tmp2.xyz = tmp1.xxx * tmp2.xyz;
                tmp3.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp3.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp3.xyz;
                tmp3.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp3.xyz;
                tmp1.x = dot(tmp3.xyz, tmp3.xyz);
                tmp1.x = rsqrt(tmp1.x);
                tmp3.xyz = tmp1.xxx * tmp3.xyz;
                tmp4.xyz = tmp2.xyz * tmp3.xyz;
                tmp4.xyz = tmp2.zxy * tmp3.yzx + -tmp4.xyz;
                tmp1.x = v.tangent.w * unity_WorldTransformParams.w;
                tmp4.xyz = tmp1.xxx * tmp4.xyz;
                o.texcoord2.y = tmp4.x;
                o.texcoord2.x = tmp3.z;
                o.texcoord2.z = tmp2.y;
                o.texcoord3.w = tmp1.y;
                o.texcoord4.w = tmp1.z;
                o.texcoord3.x = tmp3.x;
                o.texcoord4.x = tmp3.y;
                o.texcoord3.z = tmp2.z;
                o.texcoord4.z = tmp2.x;
                o.texcoord3.y = tmp4.y;
                o.texcoord4.y = tmp4.z;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord5.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                o.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
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
                tmp0 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0 = tmp0 * _Color;
                tmp1 = tex2Dlod(_CutoutMask, float4(inp.texcoord.xy, 0, 0.0));
                tmp1.x = 1.0 - tmp1.x;
                tmp1.x = tmp1.x * _CutOff;
                tmp0.w = tmp0.w < tmp1.x;
                if (tmp0.w) {
                    discard;
                }
                tmp1.y = inp.texcoord2.w;
                tmp1.z = inp.texcoord3.w;
                tmp1.w = inp.texcoord4.w;
                tmp2.xyz = _WorldSpaceCameraPos - tmp1.yzw;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp0.w = tmp2.y * inp.texcoord3.z;
                tmp0.w = inp.texcoord2.z * tmp2.x + tmp0.w;
                tmp0.w = inp.texcoord4.z * tmp2.z + tmp0.w;
                tmp3.xyz = float3(_ScrollXSpeed.x, _ScrollYSpeed.x, _ScrollSpeedRandomFactor.x) * _Time.yxy;
                tmp4.yz = frac(tmp3.xz);
                tmp1.x = cos(tmp3.y);
                tmp4.x = tmp1.x * 0.1 + tmp4.y;
                tmp3.xy = tmp4.xz + inp.texcoord1.xy;
                tmp4 = tex2D(_GlossMap, inp.texcoord.xy);
                tmp1.x = tmp4.x * _Metallic;
                tmp4 = tex2D(_NormalMap1, inp.texcoord.zw);
                tmp4.x = tmp4.w * tmp4.x;
                tmp4.xy = tmp4.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp4.xy, tmp4.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp4.z = sqrt(tmp2.w);
                tmp3 = tex2D(_NormalMap2, tmp3.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp3.xy, tmp3.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp3.z = sqrt(tmp2.w);
                tmp2.w = _NormalBlendingRandomFactor * _Time.x;
                tmp2.w = cos(tmp2.w);
                tmp2.w = tmp2.w * 0.4;
                tmp3.xyz = tmp3.xyz * _NormalBlendThreshold.xxx;
                tmp3.xyz = tmp3.xyz * tmp2.www + tmp4.xyz;
                tmp5 = tex2D(_NormalsMask, inp.texcoord.xy);
                tmp0.w = tmp0.w > 0.0;
                tmp4.xyz = tmp0.www ? tmp4.xyz : -tmp4.xyz;
                tmp3.xyz = tmp0.www ? tmp3.xyz : -tmp3.xyz;
                tmp3.xyz = tmp3.xyz - tmp4.xyz;
                tmp3.xyz = tmp5.xxx * tmp3.xyz + tmp4.xyz;
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = _ThermalVisionOn > 0.0;
                tmp4.xyz = tmp0.xyz * _Temperature.zzz;
                tmp4.xyz = max(tmp4.xyz, _Temperature.xxx);
                tmp4.xyz = min(tmp4.xyz, _Temperature.yyy);
                tmp4.xyz = tmp4.xyz + _Temperature.www;
                tmp0.xyz = tmp0.www ? tmp4.xyz : tmp0.xyz;
                tmp4.xyz = _WorldSpaceLightPos0.xyz - tmp1.yzw;
                tmp0.w = dot(tmp4.xyz, tmp4.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp4.xyz = tmp0.www * tmp4.xyz;
                tmp5.xyz = inp.texcoord3.www * unity_WorldToLight._m01_m11_m21;
                tmp5.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord2.www + tmp5.xyz;
                tmp5.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.www + tmp5.xyz;
                tmp5.xyz = tmp5.xyz + unity_WorldToLight._m03_m13_m23;
                tmp0.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp0.w) {
                    tmp0.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp6.xyz = inp.texcoord3.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.www + tmp6.xyz;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.www + tmp6.xyz;
                    tmp6.xyz = tmp6.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp1.yzw = tmp0.www ? tmp6.xyz : tmp1.yzw;
                    tmp1.yzw = tmp1.yzw - unity_ProbeVolumeMin;
                    tmp6.yzw = tmp1.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.w = tmp6.y * 0.25 + 0.75;
                    tmp1.y = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp6.x = max(tmp0.w, tmp1.y);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp6.xzw);
                } else {
                    tmp6 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.w = saturate(dot(tmp6, unity_OcclusionMaskSelector));
                tmp1.y = dot(tmp5.xyz, tmp5.xyz);
                tmp5 = tex2D(_LightTexture0, tmp1.yy);
                tmp0.w = tmp0.w * tmp5.x;
                tmp5.x = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp5.y = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp5.z = dot(inp.texcoord4.xyz, tmp3.xyz);
                tmp1.y = dot(tmp5.xyz, tmp5.xyz);
                tmp1.y = rsqrt(tmp1.y);
                tmp1.yzw = tmp1.yyy * tmp5.xyz;
                tmp3.xyz = tmp0.www * _LightColor0.xyz;
                tmp5.xyz = tmp0.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                tmp5.xyz = tmp1.xxx * tmp5.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp0.w = -tmp1.x * 0.7790837 + 0.7790837;
                tmp1.x = dot(tmp2.xyz, tmp1.xyz);
                tmp1.x = tmp1.x + tmp1.x;
                tmp2.xyz = tmp1.yzw * -tmp1.xxx + tmp2.xyz;
                tmp1.x = saturate(dot(tmp1.xyz, tmp4.xyz));
                tmp1.y = dot(tmp2.xyz, tmp4.xyz);
                tmp1.y = tmp1.y * tmp1.y;
                tmp2.x = tmp1.y * tmp1.y;
                tmp2.y = 1.0 - _Glossiness;
                tmp2 = tex2D(unity_NHxRoughness, tmp2.xy);
                tmp1.y = tmp2.x * 16.0;
                tmp1.yzw = tmp5.xyz * tmp1.yyy;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp1.yzw;
                tmp1.xyz = tmp1.xxx * tmp3.xyz;
                o.sv_target.xyz = tmp0.xyz * tmp1.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			Cull Off
			GpuProgramID 155704
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 texcoord6 : TEXCOORD6;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float _VertexTimeOffset;
			float _VertexAnimationScale;
			float _VertexAnimationSpeedMultiplier;
			float4 _MainTex_ST;
			float4 _NormalMap1_ST;
			float4 _NormalMap2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _Glossiness;
			float _Metallic;
			float4 _Color;
			float _ScrollXSpeed;
			float _ScrollYSpeed;
			float _ScrollSpeedRandomFactor;
			float _NormalBlendThreshold;
			float _NormalBlendingRandomFactor;
			float _CutOff;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			sampler2D _NoiseTex;
			sampler2D _NormalsMask;
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _CutoutMask;
			sampler2D _GlossMap;
			sampler2D _NormalMap1;
			sampler2D _NormalMap2;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = tex2Dlod(_NoiseTex, float4(v.texcoord.xy, 0, 0.0));
                tmp0.x = tmp0.x * 100.0;
                tmp0.y = _VertexTimeOffset * _Time.x;
                tmp0.x = tmp0.y * _VertexAnimationSpeedMultiplier + tmp0.x;
                tmp0.x = sin(tmp0.x);
                tmp0.xyz = tmp0.xxx * v.normal.xyz;
                tmp0.xyz = tmp0.xyz * _VertexAnimationScale.xxx;
                tmp1 = tex2Dlod(_NormalsMask, float4(v.texcoord.xy, 0, 0.0));
                tmp0.xyz = tmp0.xyz * tmp1.xxx + v.vertex.xyz;
                tmp1 = tmp0.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp1 = unity_ObjectToWorld._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
                o.texcoord2.w = tmp0.x;
                tmp0.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp1.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp1.xyz = tmp1.www * tmp1.xyz;
                tmp2.xyz = v.tangent.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp2.xyz = unity_ObjectToWorld._m00_m10_m20 * v.tangent.xxx + tmp2.xyz;
                tmp2.xyz = unity_ObjectToWorld._m02_m12_m22 * v.tangent.zzz + tmp2.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3.xyz = tmp1.zxy * tmp2.yzx;
                tmp3.xyz = tmp1.yzx * tmp2.zxy + -tmp3.xyz;
                tmp3.xyz = tmp0.www * tmp3.xyz;
                o.texcoord2.y = tmp3.x;
                o.texcoord2.x = tmp2.x;
                o.texcoord2.z = tmp1.x;
                o.texcoord3.w = tmp0.y;
                o.texcoord3.x = tmp2.y;
                o.texcoord3.z = tmp1.y;
                o.texcoord3.y = tmp3.y;
                o.texcoord4.w = tmp0.z;
                tmp0.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                o.texcoord4.x = tmp2.z;
                o.texcoord5.x = dot(tmp0.xyz, tmp2.xyz);
                o.texcoord4.z = tmp1.z;
                o.texcoord5.z = dot(tmp0.xyz, tmp1.xyz);
                o.texcoord5.y = dot(tmp0.xyz, tmp3.xyz);
                o.texcoord4.y = tmp3.z;
                o.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
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
                tmp0 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0 = tmp0 * _Color;
                tmp1 = tex2Dlod(_CutoutMask, float4(inp.texcoord.xy, 0, 0.0));
                tmp1.x = 1.0 - tmp1.x;
                tmp1.x = tmp1.x * _CutOff;
                tmp0.w = tmp0.w < tmp1.x;
                if (tmp0.w) {
                    discard;
                }
                tmp0.w = dot(inp.texcoord5.xyz, inp.texcoord5.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.w = tmp0.w * inp.texcoord5.z;
                tmp1.xyz = float3(_ScrollXSpeed.x, _ScrollYSpeed.x, _ScrollSpeedRandomFactor.x) * _Time.yxy;
                tmp2.yz = frac(tmp1.xz);
                tmp1.x = cos(tmp1.y);
                tmp2.x = tmp1.x * 0.1 + tmp2.y;
                tmp1.xy = tmp2.xz + inp.texcoord1.xy;
                tmp2 = tex2D(_GlossMap, inp.texcoord.xy);
                tmp1.z = tmp2.x * _Metallic;
                tmp2 = tex2D(_NormalMap1, inp.texcoord.zw);
                tmp2.x = tmp2.w * tmp2.x;
                tmp2.xy = tmp2.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp1.w = dot(tmp2.xy, tmp2.xy);
                tmp1.w = min(tmp1.w, 1.0);
                tmp1.w = 1.0 - tmp1.w;
                tmp2.z = sqrt(tmp1.w);
                tmp3 = tex2D(_NormalMap2, tmp1.xy);
                tmp3.x = tmp3.w * tmp3.x;
                tmp3.xy = tmp3.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp1.x = dot(tmp3.xy, tmp3.xy);
                tmp1.x = min(tmp1.x, 1.0);
                tmp1.x = 1.0 - tmp1.x;
                tmp3.z = sqrt(tmp1.x);
                tmp1.x = _NormalBlendingRandomFactor * _Time.x;
                tmp1.x = cos(tmp1.x);
                tmp1.x = tmp1.x * 0.4;
                tmp3.xyz = tmp3.xyz * _NormalBlendThreshold.xxx;
                tmp1.xyw = tmp3.xyz * tmp1.xxx + tmp2.xyz;
                tmp3 = tex2D(_NormalsMask, inp.texcoord.xy);
                tmp0.w = tmp0.w > 0.0;
                tmp2.xyz = tmp0.www ? tmp2.xyz : -tmp2.xyz;
                tmp1.xyw = tmp0.www ? tmp1.xyw : -tmp1.xyw;
                tmp1.xyw = tmp1.xyw - tmp2.xyz;
                tmp1.xyw = tmp3.xxx * tmp1.xyw + tmp2.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyw = tmp0.www * tmp1.xyw;
                tmp0.w = _ThermalVisionOn > 0.0;
                tmp2.xyz = tmp0.xyz * _Temperature.zzz;
                tmp2.xyz = max(tmp2.xyz, _Temperature.xxx);
                tmp2.xyz = min(tmp2.xyz, _Temperature.yyy);
                tmp2.xyz = tmp2.xyz + _Temperature.www;
                tmp0.xyz = tmp0.www ? tmp2.xyz : tmp0.xyz;
                tmp2.x = dot(inp.texcoord2.xyz, tmp1.xyz);
                tmp2.y = dot(inp.texcoord3.xyz, tmp1.xyz);
                tmp2.z = dot(inp.texcoord4.xyz, tmp1.xyz);
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyw = tmp0.www * tmp2.xyz;
                tmp2.xyz = tmp0.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                o.sv_target1.xyz = tmp1.zzz * tmp2.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp0.w = -tmp1.z * 0.7790837 + 0.7790837;
                o.sv_target.xyz = tmp0.www * tmp0.xyz;
                o.sv_target2.xyz = tmp1.xyw * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                o.sv_target.w = 1.0;
                o.sv_target1.w = _Glossiness;
                o.sv_target2.w = 1.0;
                //o.sv_target3 = float4(1.0, 1.0, 1.0, 1.0);
                return o;
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}