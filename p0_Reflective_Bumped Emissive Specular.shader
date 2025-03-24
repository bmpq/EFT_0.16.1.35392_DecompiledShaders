Shader "p0/Reflective/Bumped Emissive Specular" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_SpecPower ("Specular Power", Range(0.01, 10)) = 1
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_EmissionMap ("EmissionMap", 2D) = "white" {}
		_EmissionVisibility ("EmissionVisibility", Range(0, 1)) = 1
		_EmissionPower ("EmissionPower", Range(0, 10)) = 1
		_SpecVals ("Specular Vals", Vector) = (1.1,2,0,0)
		_DefVals ("Defuse Vals", Vector) = (0.5,0.7,0,0)
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,1,2,0)
	}
	SubShader {
		LOD 400
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 31299
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
				float4 texcoord6 : TEXCOORD6;
				float4 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			float4 _BumpMap_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _SpecColor;
			float4 _Color;
			float4 _ReflectColor;
			float _Shininess;
			float _SpecPower;
			float _EmissionVisibility;
			float _EmissionPower;
			float3 _SpecVals;
			float3 _DefVals;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _EmissionMap;
			
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
                o.texcoord.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
                o.texcoord6 = float4(0.0, 0.0, 0.0, 0.0);
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
                float4 tmp7;
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
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp4.w * _SpecPower;
                tmp2.w = _SpecPower * _Shininess;
                tmp5 = tex2D(_BumpMap, inp.texcoord.zw);
                tmp5.x = tmp5.w * tmp5.x;
                tmp5.xy = tmp5.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp3.w = dot(tmp5.xy, tmp5.xy);
                tmp3.w = min(tmp3.w, 1.0);
                tmp3.w = 1.0 - tmp3.w;
                tmp5.z = sqrt(tmp3.w);
                tmp6.x = dot(inp.texcoord1.xyz, tmp5.xyz);
                tmp6.y = dot(inp.texcoord2.xyz, tmp5.xyz);
                tmp6.z = dot(inp.texcoord3.xyz, tmp5.xyz);
                tmp3.w = dot(-tmp2.xyz, tmp6.xyz);
                tmp3.w = tmp3.w + tmp3.w;
                tmp2.xyz = tmp6.xyz * -tmp3.www + -tmp2.xyz;
                tmp7 = texCUBE(_Cube, tmp2.xyz);
                tmp2.xyz = tmp4.www * tmp7.xyz;
                tmp2.xyz = tmp2.xyz * _ReflectColor.xyz;
                tmp7 = tex2D(_EmissionMap, inp.texcoord.xy);
                tmp7.xyz = tmp7.xyz * _EmissionPower.xxx + -tmp2.xyz;
                tmp2.xyz = _EmissionVisibility.xxx * tmp7.xyz + tmp2.xyz;
                tmp3.w = dot(tmp3.xyz, tmp3.xyz);
                tmp3.w = rsqrt(tmp3.w);
                tmp3.xyz = tmp3.www * tmp3.xyz;
                tmp3.x = dot(tmp3.xyz, tmp5.xyz);
                tmp3.x = 1.0 - tmp3.x;
                tmp3.x = tmp3.x * tmp3.x;
                tmp3.x = tmp3.x * 0.5;
                tmp3.y = _SpecVals.y * tmp3.x + _SpecVals.x;
                tmp3.y = tmp3.y * 0.5;
                tmp3.x = _DefVals.y * tmp3.x + _DefVals.x;
                tmp3.xzw = tmp3.xxx * tmp4.xyz;
                tmp1.w = tmp1.w * tmp3.y;
                tmp4.x = _ThermalVisionOn > 0.0;
                tmp4.yzw = tmp3.xzw * _Temperature.zzz;
                tmp4.yzw = max(tmp4.yzw, _Temperature.xxx);
                tmp4.yzw = min(tmp4.yzw, _Temperature.yyy);
                tmp4.yzw = tmp4.yzw + _Temperature.www;
                tmp3.xzw = tmp4.xxx ? tmp4.yzw : tmp3.xzw;
                tmp4.x = unity_ProbeVolumeParams.x == 1.0;
                if (tmp4.x) {
                    tmp4.x = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.yzw = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.yzw = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp4.yzw;
                    tmp4.yzw = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp4.yzw;
                    tmp4.yzw = tmp4.yzw + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp4.xxx ? tmp4.yzw : tmp0.yzw;
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
                tmp0.z = dot(tmp6.xyz, tmp6.xyz);
                tmp0.z = rsqrt(tmp0.z);
                tmp4.xyz = tmp0.zzz * tmp6.xyz;
                tmp0.yzw = tmp0.yyy * _LightColor0.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.xxx + _WorldSpaceLightPos0.xyz;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(tmp4.xyz, _WorldSpaceLightPos0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp1.x = dot(tmp4.xyz, tmp1.xyz);
                tmp1.x = max(tmp1.x, 0.0);
                tmp1.y = tmp2.w * 128.0;
                tmp1.x = log(tmp1.x);
                tmp1.x = tmp1.x * tmp1.y;
                tmp1.x = exp(tmp1.x);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.yzw = tmp0.yzw * tmp3.xzw;
                tmp0.yzw = tmp0.yzw * _SpecColor.xyz;
                tmp0.yzw = tmp1.xxx * tmp0.yzw;
                tmp0.xyz = tmp1.yzw * tmp0.xxx + tmp0.yzw;
                o.sv_target.xyz = tmp2.xyz * tmp3.yyy + tmp0.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 81026
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
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
			float4 _BumpMap_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _SpecColor;
			float4 _Color;
			float _Shininess;
			float _SpecPower;
			float3 _SpecVals;
			float3 _DefVals;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
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
                o.texcoord.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp4.w * _SpecPower;
                tmp2.w = _SpecPower * _Shininess;
                tmp5 = tex2D(_BumpMap, inp.texcoord.zw);
                tmp5.x = tmp5.w * tmp5.x;
                tmp5.xy = tmp5.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp3.w = dot(tmp5.xy, tmp5.xy);
                tmp3.w = min(tmp3.w, 1.0);
                tmp3.w = 1.0 - tmp3.w;
                tmp5.z = sqrt(tmp3.w);
                tmp3.w = dot(tmp3.xyz, tmp3.xyz);
                tmp3.w = rsqrt(tmp3.w);
                tmp3.xyz = tmp3.www * tmp3.xyz;
                tmp3.x = dot(tmp3.xyz, tmp5.xyz);
                tmp3.x = 1.0 - tmp3.x;
                tmp3.x = tmp3.x * tmp3.x;
                tmp3.x = tmp3.x * 0.5;
                tmp3.y = _SpecVals.y * tmp3.x + _SpecVals.x;
                tmp3.y = tmp3.y * 0.5;
                tmp3.x = _DefVals.y * tmp3.x + _DefVals.x;
                tmp3.xzw = tmp3.xxx * tmp4.xyz;
                tmp1.w = tmp1.w * tmp3.y;
                tmp3.y = _ThermalVisionOn > 0.0;
                tmp4.xyz = tmp3.xzw * _Temperature.zzz;
                tmp4.xyz = max(tmp4.xyz, _Temperature.xxx);
                tmp4.xyz = min(tmp4.xyz, _Temperature.yyy);
                tmp4.xyz = tmp4.xyz + _Temperature.www;
                tmp3.xyz = tmp3.yyy ? tmp4.xyz : tmp3.xzw;
                tmp4.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp4.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp4.xyz;
                tmp4.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp4.xyz;
                tmp4.xyz = tmp4.xyz + unity_WorldToLight._m03_m13_m23;
                tmp3.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp3.w) {
                    tmp3.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp6.xyz = inp.texcoord4.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord4.xxx + tmp6.xyz;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.zzz + tmp6.xyz;
                    tmp6.xyz = tmp6.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp6.xyz = tmp3.www ? tmp6.xyz : inp.texcoord4.xyz;
                    tmp6.xyz = tmp6.xyz - unity_ProbeVolumeMin;
                    tmp6.yzw = tmp6.xyz * unity_ProbeVolumeSizeInv;
                    tmp3.w = tmp6.y * 0.25 + 0.75;
                    tmp4.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp6.x = max(tmp3.w, tmp4.w);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp6.xzw);
                } else {
                    tmp6 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp3.w = saturate(dot(tmp6, unity_OcclusionMaskSelector));
                tmp4.x = dot(tmp4.xyz, tmp4.xyz);
                tmp4 = tex2D(_LightTexture0, tmp4.xx);
                tmp3.w = tmp3.w * tmp4.x;
                tmp4.x = dot(inp.texcoord1.xyz, tmp5.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp5.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp5.xyz);
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
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "PREPASS"
			LOD 400
			Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
			GpuProgramID 185360
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
			float4 _BumpMap_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _Shininess;
			float _SpecPower;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _BumpMap;
			
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
                o.texcoord.xy = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
			// Keywords: 
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
                o.sv_target.w = _SpecPower * _Shininess;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "PREPASS"
			LOD 400
			Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
			ZWrite Off
			GpuProgramID 210561
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
			float4 _BumpMap_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _SpecColor;
			float4 _Color;
			float4 _ReflectColor;
			float _SpecPower;
			float _EmissionVisibility;
			float _EmissionPower;
			float3 _SpecVals;
			float3 _DefVals;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _EmissionMap;
			sampler2D _LightBuffer;
			
			// Keywords: 
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
                o.texcoord.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                float4 tmp4;
                tmp0.x = inp.texcoord1.w;
                tmp0.y = inp.texcoord2.w;
                tmp0.z = inp.texcoord3.w;
                tmp0.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1.xyz = tmp0.yyy * inp.texcoord2.xyz;
                tmp1.xyz = inp.texcoord1.xyz * tmp0.xxx + tmp1.xyz;
                tmp1.xyz = inp.texcoord3.xyz * tmp0.zzz + tmp1.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp2 = tex2D(_BumpMap, inp.texcoord.zw);
                tmp2.x = tmp2.w * tmp2.x;
                tmp2.xy = tmp2.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp2.xy, tmp2.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp2.z = sqrt(tmp0.w);
                tmp0.w = dot(tmp1.xyz, tmp2.xyz);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.w = tmp0.w * 0.5;
                tmp1.x = _DefVals.y * tmp0.w + _DefVals.x;
                tmp0.w = _SpecVals.y * tmp0.w + _SpecVals.x;
                tmp0.w = tmp0.w * 0.5;
                tmp3 = tex2D(_MainTex, inp.texcoord.xy);
                tmp1.yzw = tmp3.xyz * _Color.xyz;
                tmp1.xyz = tmp1.xxx * tmp1.yzw;
                tmp3.xyz = tmp1.xyz * _Temperature.zzz;
                tmp3.xyz = max(tmp3.xyz, _Temperature.xxx);
                tmp3.xyz = min(tmp3.xyz, _Temperature.yyy);
                tmp3.xyz = tmp3.xyz + _Temperature.www;
                tmp1.w = _ThermalVisionOn > 0.0;
                tmp1.xyz = tmp1.www ? tmp3.xyz : tmp1.xyz;
                tmp1.w = tmp3.w * _SpecPower;
                tmp1.w = tmp0.w * tmp1.w;
                tmp3.xy = inp.texcoord4.xy / inp.texcoord4.ww;
                tmp4 = tex2D(_LightBuffer, tmp3.xy);
                tmp4 = log(tmp4);
                tmp1.w = tmp1.w * -tmp4.w;
                tmp3.xyz = inp.texcoord6.xyz - tmp4.xyz;
                tmp4.xyz = tmp3.xyz * _SpecColor.xyz;
                tmp4.xyz = tmp1.www * tmp4.xyz;
                tmp1.xyz = tmp1.xyz * tmp3.xyz + tmp4.xyz;
                tmp3.x = dot(inp.texcoord1.xyz, tmp2.xyz);
                tmp3.y = dot(inp.texcoord2.xyz, tmp2.xyz);
                tmp3.z = dot(inp.texcoord3.xyz, tmp2.xyz);
                tmp1.w = dot(-tmp0.xyz, tmp3.xyz);
                tmp1.w = tmp1.w + tmp1.w;
                tmp0.xyz = tmp3.xyz * -tmp1.www + -tmp0.xyz;
                tmp2 = texCUBE(_Cube, tmp0.xyz);
                tmp0.xyz = tmp3.www * tmp2.xyz;
                tmp0.xyz = tmp0.xyz * _ReflectColor.xyz;
                tmp2 = tex2D(_EmissionMap, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * _EmissionPower.xxx + -tmp0.xyz;
                tmp0.xyz = _EmissionVisibility.xxx * tmp2.xyz + tmp0.xyz;
                o.sv_target.xyz = tmp0.xyz * tmp0.www + tmp1.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			LOD 400
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			GpuProgramID 325460
			CGPROGRAM
            #pragma multi_compile ___ UNITY_HDR_ON
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
				float3 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
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
			float4 _BumpMap_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _SpecColor;
			float4 _Color;
			float4 _ReflectColor;
			float _Shininess;
			float _SpecPower;
			float _EmissionVisibility;
			float _EmissionPower;
			float3 _SpecVals;
			float3 _DefVals;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _EmissionMap;
			
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
                o.texcoord.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
                o.texcoord1.w = tmp0.x;
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
                o.texcoord1.y = tmp3.x;
                o.texcoord1.x = tmp2.x;
                o.texcoord1.z = tmp1.x;
                o.texcoord2.x = tmp2.y;
                o.texcoord2.z = tmp1.y;
                o.texcoord2.w = tmp0.y;
                o.texcoord2.y = tmp3.y;
                o.texcoord3.x = tmp2.z;
                o.texcoord3.z = tmp1.z;
                o.texcoord3.w = tmp0.z;
                tmp0.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                o.texcoord3.y = tmp3.z;
                o.texcoord4.y = dot(tmp0.xyz, tmp3.xyz);
                o.texcoord4.x = dot(tmp0.xyz, tmp2.xyz);
                o.texcoord4.z = dot(tmp0.xyz, tmp1.xyz);
                o.texcoord5 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                tmp0.x = dot(inp.texcoord4.xyz, inp.texcoord4.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp0.xyz = tmp0.xxx * inp.texcoord4.xyz;
                tmp1 = tex2D(_BumpMap, inp.texcoord.zw);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.xy = tmp1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp1.xy, tmp1.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp1.z = sqrt(tmp0.w);
                tmp0.x = dot(tmp0.xyz, tmp1.xyz);
                tmp0.x = 1.0 - tmp0.x;
                tmp0.x = tmp0.x * tmp0.x;
                tmp0.x = tmp0.x * 0.5;
                tmp0.y = _DefVals.y * tmp0.x + _DefVals.x;
                tmp0.x = _SpecVals.y * tmp0.x + _SpecVals.x;
                tmp0.x = tmp0.x * 0.5;
                tmp2 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * _Color.xyz;
                tmp0.yzw = tmp0.yyy * tmp2.xyz;
                tmp2.xyz = tmp0.yzw * _Temperature.zzz;
                tmp2.xyz = max(tmp2.xyz, _Temperature.xxx);
                tmp2.xyz = min(tmp2.xyz, _Temperature.yyy);
                tmp2.xyz = tmp2.xyz + _Temperature.www;
                tmp1.w = _ThermalVisionOn > 0.0;
                o.sv_target.xyz = tmp1.www ? tmp2.xyz : tmp0.yzw;
                o.sv_target.w = 1.0;
                tmp0.y = tmp2.w * _SpecPower;
                tmp0.y = tmp0.x * tmp0.y;
                o.sv_target1.xyz = tmp0.yyy * _SpecColor.xyz;
                o.sv_target1.w = _SpecPower * _Shininess;
                tmp2.x = dot(inp.texcoord1.xyz, tmp1.xyz);
                tmp2.y = dot(inp.texcoord2.xyz, tmp1.xyz);
                tmp2.z = dot(inp.texcoord3.xyz, tmp1.xyz);
                tmp0.y = dot(tmp2.xyz, tmp2.xyz);
                tmp0.y = rsqrt(tmp0.y);
                tmp0.yzw = tmp0.yyy * tmp2.xyz;
                o.sv_target2.xyz = tmp0.yzw * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                o.sv_target2.w = 1.0;
                tmp1.x = inp.texcoord1.w;
                tmp1.y = inp.texcoord2.w;
                tmp1.z = inp.texcoord3.w;
                tmp0.yzw = _WorldSpaceCameraPos - tmp1.xyz;
                tmp1.x = dot(tmp0.xyz, tmp0.xyz);
                tmp1.x = rsqrt(tmp1.x);
                tmp0.yzw = tmp0.yzw * tmp1.xxx;
                tmp1.x = dot(-tmp0.xyz, tmp2.xyz);
                tmp1.x = tmp1.x + tmp1.x;
                tmp0.yzw = tmp2.xyz * -tmp1.xxx + -tmp0.yzw;
                tmp1 = texCUBE(_Cube, tmp0.yzw);
                tmp0.yzw = tmp2.www * tmp1.xyz;
                tmp0.yzw = tmp0.yzw * _ReflectColor.xyz;
                tmp1 = tex2D(_EmissionMap, inp.texcoord.xy);
                tmp1.xyz = tmp1.xyz * _EmissionPower.xxx + -tmp0.yzw;
                tmp0.yzw = _EmissionVisibility.xxx * tmp1.xyz + tmp0.yzw;
                tmp0.xyz = tmp0.xxx * tmp0.yzw;
                
                #ifdef UNITY_HDR_ON
                    o.sv_target3 = float4(0, 0, 0, 1.0);
                #else
                    o.sv_target3.xyz = exp(-tmp0.xyz);
                #endif

                o.sv_target3.w = 1.0;
                return o;
			}
			ENDCG
		}
		UsePass "Hidden/Internal-ShadowCaster/ShadowCaster"
	}
	Fallback "Hidden/Internal-BlackError"
}