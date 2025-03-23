Shader "RainyShaders/Reflect Bumped Specular Alpha Distort Rainy" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_RainFlow ("RainFlow", 2D) = "black" {}
		_RainGradient ("RainGradient", 2D) = "black" {}
		_RainPower ("RainPower", Range(0, 1)) = 1
		_RainSpeed ("RainSpeed", Range(0, 2)) = 1
		_RainTilingX ("RainTilingX", Float) = 1
		_RainTilingY ("RainTilingY", Float) = 1
		_fallow ("_RimReflection", Range(0.01, 1.5)) = 1
		_level ("_RimReflection_2", Range(0.01, 1.5)) = 1
		_Distort ("Distort", Range(0.03, 1.5)) = 0.03
		_WaterContrast ("WaterContrast", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 400
		Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
		GrabPass {
			"_MyGrabTexture"
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Fog {
				Mode Off
			}
			GpuProgramID 26283
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
				float4 texcoord8 : TEXCOORD8;
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
			float _RainPower;
			float _RainSpeed;
			float _RainTilingY;
			float _RainTilingX;
			float _fallow;
			float _level;
			float _Distort;
			float _WaterContrast;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _RainGradient;
			sampler2D _RainFlow;
			sampler2D _MainTex;
			sampler2D _BumpMap;
			samplerCUBE _Cube;
			sampler2D _MyGrabTexture;
			
			// Keywords: DIRECTIONAL
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
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.x = dot(tmp2.xyz, tmp2.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp2.xyz = tmp0.xxx * tmp2.xyz;
                tmp3.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp3.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp3.xyz;
                tmp3.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp3.xyz;
                tmp0.x = dot(tmp3.xyz, tmp3.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp3.xyz = tmp0.xxx * tmp3.xyz;
                tmp4.xyz = tmp2.xyz * tmp3.xyz;
                tmp4.xyz = tmp2.zxy * tmp3.yzx + -tmp4.xyz;
                tmp0.x = v.tangent.w * unity_WorldTransformParams.w;
                tmp4.xyz = tmp0.xxx * tmp4.xyz;
                o.texcoord1.y = tmp4.x;
                o.texcoord1.x = tmp3.z;
                o.texcoord1.z = tmp2.y;
                o.texcoord2.x = tmp3.x;
                o.texcoord3.x = tmp3.y;
                o.texcoord2.z = tmp2.z;
                o.texcoord3.z = tmp2.x;
                o.texcoord2.w = tmp0.y;
                o.texcoord3.w = tmp0.z;
                o.texcoord2.y = tmp4.y;
                o.texcoord3.y = tmp4.z;
                tmp0.xyz = tmp1.xwy * float3(0.5, 0.5, -0.5);
                o.texcoord4.zw = tmp1.zw;
                o.texcoord4.xy = tmp0.yy + tmp0.xz;
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
                tmp4.x = _Time.y * _RainSpeed + inp.texcoord.y;
                tmp4.y = inp.texcoord.x;
                tmp5 = tex2D(_RainGradient, tmp4.yx);
                tmp4.z = tmp4.x + 0.3;
                tmp4.xy = tmp4.yz * float2(0.8, 0.8);
                tmp4 = tex2D(_RainGradient, tmp4.xy);
                tmp4 = tmp4 + tmp5;
                tmp5.x = inp.texcoord.x * _RainTilingX;
                tmp1.w = _Time.y * 0.1;
                tmp1.w = tmp1.w * _RainSpeed;
                tmp5.y = inp.texcoord.y * _RainTilingY + tmp1.w;
                tmp5 = tex2D(_RainFlow, tmp5.xy);
                tmp4 = tmp4 * tmp5;
                tmp5 = tmp4 * _RainPower.xxxx;
                tmp4.xy = tmp4.xy * _RainPower.xx + inp.texcoord.xy;
                tmp4 = tex2D(_MainTex, tmp4.xy);
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp5.x + tmp5.x;
                tmp1.w = tmp4.w * 2.0 + tmp1.w;
                tmp6.xy = tmp5.xy * float2(0.2, 0.2) + inp.texcoord.zw;
                tmp6 = tex2D(_BumpMap, tmp6.xy);
                tmp6.x = tmp6.w * tmp6.x;
                tmp6.xy = tmp6.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp6.xy, tmp6.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp6.z = sqrt(tmp2.w);
                tmp7.x = dot(inp.texcoord1.xyz, tmp6.xyz);
                tmp7.y = dot(inp.texcoord2.xyz, tmp6.xyz);
                tmp7.z = dot(inp.texcoord3.xyz, tmp6.xyz);
                tmp2.w = dot(-tmp2.xyz, tmp7.xyz);
                tmp2.w = tmp2.w + tmp2.w;
                tmp2.xyz = tmp7.xyz * -tmp2.www + -tmp2.xyz;
                tmp2 = texCUBE(_Cube, tmp2.xyz);
                tmp2.w = dot(tmp3.xyz, tmp3.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp2.w = -tmp3.z * tmp2.w + 1.0;
                tmp2.w = tmp2.w * _fallow + _level;
                tmp2.xyz = tmp4.www * tmp2.xyz;
                tmp2.xyz = tmp2.xyz * _ReflectColor.xyz;
                tmp3.xyz = tmp6.yyy * _Distort.xxx + inp.texcoord4.xyw;
                tmp3.xyz = tmp5.xyw * float3(0.2, 0.2, 0.2) + tmp3.xyz;
                tmp3.xy = tmp3.xy / tmp3.zz;
                tmp3 = tex2D(_MyGrabTexture, tmp3.xy);
                tmp2.xyz = tmp2.xyz * tmp2.www + tmp3.xyz;
                tmp2.xyz = tmp5.xyz * _WaterContrast.xxx + tmp2.xyz;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp3.xyz = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp3.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp3.xyz;
                    tmp3.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp3.xyz;
                    tmp3.xyz = tmp3.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp2.www ? tmp3.xyz : tmp0.yzw;
                    tmp0.yzw = tmp0.yzw - unity_ProbeVolumeMin;
                    tmp3.yzw = tmp0.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp3.y * 0.25 + 0.75;
                    tmp0.z = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp3.x = max(tmp0.z, tmp0.y);
                    tmp3 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp3.xzw);
                } else {
                    tmp3 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.y = saturate(dot(tmp3, unity_OcclusionMaskSelector));
                tmp0.z = dot(tmp7.xyz, tmp7.xyz);
                tmp0.z = rsqrt(tmp0.z);
                tmp3.xyz = tmp0.zzz * tmp7.xyz;
                tmp0.yzw = tmp0.yyy * _LightColor0.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.xxx + _WorldSpaceLightPos0.xyz;
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp1.xyz = tmp0.xxx * tmp1.xyz;
                tmp0.x = dot(tmp3.xyz, _WorldSpaceLightPos0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp1.x = dot(tmp3.xyz, tmp1.xyz);
                tmp1.x = max(tmp1.x, 0.0);
                tmp1.y = _Shininess * 128.0;
                tmp1.x = log(tmp1.x);
                tmp1.x = tmp1.x * tmp1.y;
                tmp1.x = exp(tmp1.x);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.yzw = tmp0.yzw * tmp4.xyz;
                tmp0.yzw = tmp0.yzw * _SpecColor.xyz;
                tmp0.yzw = tmp1.xxx * tmp0.yzw;
                tmp0.xyz = tmp1.yzw * tmp0.xxx + tmp0.yzw;
                o.sv_target.xyz = tmp2.xyz + tmp0.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			Fog {
				Mode Off
			}
			GpuProgramID 106975
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
				float4 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
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
			float _RainPower;
			float _RainSpeed;
			float _RainTilingY;
			float _RainTilingX;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _RainGradient;
			sampler2D _RainFlow;
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
                float4 tmp4;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                tmp1 = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.position = tmp1;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp2.w = dot(tmp2.xyz, tmp2.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp2.xyz = tmp2.www * tmp2.xyz;
                tmp3.xyz = v.tangent.yyy * unity_ObjectToWorld._m11_m21_m01;
                tmp3.xyz = unity_ObjectToWorld._m10_m20_m00 * v.tangent.xxx + tmp3.xyz;
                tmp3.xyz = unity_ObjectToWorld._m12_m22_m02 * v.tangent.zzz + tmp3.xyz;
                tmp2.w = dot(tmp3.xyz, tmp3.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp3.xyz = tmp2.www * tmp3.xyz;
                tmp4.xyz = tmp2.xyz * tmp3.xyz;
                tmp4.xyz = tmp2.zxy * tmp3.yzx + -tmp4.xyz;
                tmp2.w = v.tangent.w * unity_WorldTransformParams.w;
                tmp4.xyz = tmp2.www * tmp4.xyz;
                o.texcoord1.y = tmp4.x;
                o.texcoord1.x = tmp3.z;
                o.texcoord1.z = tmp2.y;
                o.texcoord2.x = tmp3.x;
                o.texcoord3.x = tmp3.y;
                o.texcoord2.z = tmp2.z;
                o.texcoord3.z = tmp2.x;
                o.texcoord2.y = tmp4.y;
                o.texcoord3.y = tmp4.z;
                o.texcoord4.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                tmp2.xyz = tmp1.xwy * float3(0.5, 0.5, -0.5);
                o.texcoord5.zw = tmp1.zw;
                o.texcoord5.xy = tmp2.yy + tmp2.xz;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord6.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
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
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord4.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1.xyz = _WorldSpaceCameraPos - inp.texcoord4.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.x = _Time.y * _RainSpeed + inp.texcoord.y;
                tmp2.y = inp.texcoord.x;
                tmp3 = tex2D(_RainGradient, tmp2.yx);
                tmp2.z = tmp2.x + 0.3;
                tmp2.xy = tmp2.yz * float2(0.8, 0.8);
                tmp2 = tex2D(_RainGradient, tmp2.xy);
                tmp2.xy = tmp2.xy + tmp3.xy;
                tmp3.x = inp.texcoord.x * _RainTilingX;
                tmp1.w = _Time.y * 0.1;
                tmp1.w = tmp1.w * _RainSpeed;
                tmp3.y = inp.texcoord.y * _RainTilingY + tmp1.w;
                tmp3 = tex2D(_RainFlow, tmp3.xy);
                tmp2.xy = tmp2.xy * tmp3.xy;
                tmp2.zw = tmp2.xy * _RainPower.xx;
                tmp2.xy = tmp2.xy * _RainPower.xx + inp.texcoord.xy;
                tmp3 = tex2D(_MainTex, tmp2.xy);
                tmp3.xyz = tmp3.xyz * _Color.xyz;
                tmp1.w = tmp2.z + tmp2.z;
                tmp1.w = tmp3.w * 2.0 + tmp1.w;
                tmp2.xy = tmp2.zw * float2(0.2, 0.2) + inp.texcoord.zw;
                tmp2 = tex2D(_BumpMap, tmp2.xy);
                tmp2.x = tmp2.w * tmp2.x;
                tmp2.xy = tmp2.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp2.xy, tmp2.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp2.z = sqrt(tmp2.w);
                tmp4.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp4.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp4.xyz;
                tmp4.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp4.xyz;
                tmp4.xyz = tmp4.xyz + unity_WorldToLight._m03_m13_m23;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord4.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord4.xxx + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.zzz + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp5.xyz = tmp2.www ? tmp5.xyz : inp.texcoord4.xyz;
                    tmp5.xyz = tmp5.xyz - unity_ProbeVolumeMin;
                    tmp5.yzw = tmp5.xyz * unity_ProbeVolumeSizeInv;
                    tmp2.w = tmp5.y * 0.25 + 0.75;
                    tmp3.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp5.x = max(tmp2.w, tmp3.w);
                    tmp5 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp5.xzw);
                } else {
                    tmp5 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp2.w = saturate(dot(tmp5, unity_OcclusionMaskSelector));
                tmp3.w = dot(tmp4.xyz, tmp4.xyz);
                tmp4 = tex2D(_LightTexture0, tmp3.ww);
                tmp2.w = tmp2.w * tmp4.x;
                tmp4.x = dot(inp.texcoord1.xyz, tmp2.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp2.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp2.xyz);
                tmp2.x = dot(tmp4.xyz, tmp4.xyz);
                tmp2.x = rsqrt(tmp2.x);
                tmp2.xyz = tmp2.xxx * tmp4.xyz;
                tmp4.xyz = tmp2.www * _LightColor0.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.www + tmp0.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp0.x = dot(tmp2.xyz, tmp0.xyz);
                tmp0.y = dot(tmp2.xyz, tmp1.xyz);
                tmp0.xy = max(tmp0.xy, float2(0.0, 0.0));
                tmp0.z = _Shininess * 128.0;
                tmp0.y = log(tmp0.y);
                tmp0.y = tmp0.y * tmp0.z;
                tmp0.y = exp(tmp0.y);
                tmp0.y = tmp1.w * tmp0.y;
                tmp1.xyz = tmp3.xyz * tmp4.xyz;
                tmp2.xyz = tmp4.xyz * _SpecColor.xyz;
                tmp0.yzw = tmp0.yyy * tmp2.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.xxx + tmp0.yzw;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
	}
	Fallback "RainyShaders/Reflect Bumped Specular Alpha Rainy"
}