Shader "RainyShaders/Reflect Bumped Specular Alpha Rainy" {
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
		_RainPower ("RainPower", Range(0, 2)) = 1
		_RainSpeed ("RainSpeed", Range(0, 2)) = 1
		_RainTilingX ("RainTilingX", Float) = 1
		_RainTilingY ("RainTilingY", Float) = 1
		_fallow ("_RimReflection", Range(0.01, 1.5)) = 1
		_level ("_RimReflection_2", Range(0.01, 1.5)) = 1
		_WaterContrast ("WaterContrast", Range(0, 2)) = 0.5
	}
	SubShader {
		LOD 400
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			GpuProgramID 48472
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
			float _RainPower;
			float _RainSpeed;
			float _RainTilingY;
			float _RainTilingX;
			float _fallow;
			float _level;
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
                tmp4.x = _Time.y * _RainSpeed + inp.texcoord.y;
                tmp4.y = inp.texcoord.x;
                tmp5 = tex2D(_RainGradient, tmp4.yx);
                tmp4.z = tmp4.x + 0.3;
                tmp4.xy = tmp4.yz * float2(0.8, 0.8);
                tmp4 = tex2D(_RainGradient, tmp4.xy);
                tmp4.xyz = tmp4.xyz + tmp5.xyz;
                tmp5.x = inp.texcoord.x * _RainTilingX;
                tmp1.w = _Time.y * 0.1;
                tmp1.w = tmp1.w * _RainSpeed;
                tmp5.y = inp.texcoord.y * _RainTilingY + tmp1.w;
                tmp5 = tex2D(_RainFlow, tmp5.xy);
                tmp4.xyz = tmp4.xyz * tmp5.xyz;
                tmp5.xyz = tmp4.xyz * _RainPower.xxx;
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
                tmp3.x = dot(tmp3.xyz, tmp3.xyz);
                tmp3.x = rsqrt(tmp3.x);
                tmp3.x = -tmp3.z * tmp3.x + 1.0;
                tmp3.x = tmp3.x * _fallow + _level;
                tmp2 = tmp4.wwww * tmp2;
                tmp2.xyz = tmp5.xyz * _WaterContrast.xxx + tmp2.xyz;
                tmp2.xyz = tmp2.xyz * _ReflectColor.xyz;
                o.sv_target.w = tmp2.w * _Color.w + tmp5.x;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp3.yzw = inp.texcoord2.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp3.yzw = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord1.www + tmp3.yzw;
                    tmp3.yzw = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.www + tmp3.yzw;
                    tmp3.yzw = tmp3.yzw + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp0.yzw = tmp2.www ? tmp3.yzw : tmp0.yzw;
                    tmp0.yzw = tmp0.yzw - unity_ProbeVolumeMin;
                    tmp5.yzw = tmp0.yzw * unity_ProbeVolumeSizeInv;
                    tmp0.y = tmp5.y * 0.25 + 0.75;
                    tmp0.z = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp5.x = max(tmp0.z, tmp0.y);
                    tmp5 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp5.xzw);
                } else {
                    tmp5 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp0.y = saturate(dot(tmp5, unity_OcclusionMaskSelector));
                tmp0.z = dot(tmp7.xyz, tmp7.xyz);
                tmp0.z = rsqrt(tmp0.z);
                tmp3.yzw = tmp0.zzz * tmp7.xyz;
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
                o.sv_target.xyz = tmp2.xyz * tmp3.xxx + tmp0.xyz;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 107566
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
			samplerCUBE _Cube;
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
                tmp3.x = _Time.y * _RainSpeed + inp.texcoord.y;
                tmp3.y = inp.texcoord.x;
                tmp4 = tex2D(_RainGradient, tmp3.yx);
                tmp3.z = tmp3.x + 0.3;
                tmp3.xy = tmp3.yz * float2(0.8, 0.8);
                tmp3 = tex2D(_RainGradient, tmp3.xy);
                tmp3.xy = tmp3.xy + tmp4.xy;
                tmp4.x = inp.texcoord.x * _RainTilingX;
                tmp1.w = _Time.y * 0.1;
                tmp1.w = tmp1.w * _RainSpeed;
                tmp4.y = inp.texcoord.y * _RainTilingY + tmp1.w;
                tmp4 = tex2D(_RainFlow, tmp4.xy);
                tmp3.xy = tmp3.xy * tmp4.xy;
                tmp3.zw = tmp3.xy * _RainPower.xx;
                tmp3.xy = tmp3.xy * _RainPower.xx + inp.texcoord.xy;
                tmp4 = tex2D(_MainTex, tmp3.xy);
                tmp4.xyz = tmp4.xyz * _Color.xyz;
                tmp1.w = tmp3.z + tmp3.z;
                tmp1.w = tmp4.w * 2.0 + tmp1.w;
                tmp3.xy = tmp3.zw * float2(0.2, 0.2) + inp.texcoord.zw;
                tmp5 = tex2D(_BumpMap, tmp3.xy);
                tmp5.x = tmp5.w * tmp5.x;
                tmp5.xy = tmp5.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp5.xy, tmp5.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp5.z = sqrt(tmp2.w);
                tmp6.x = dot(inp.texcoord1.xyz, tmp5.xyz);
                tmp6.y = dot(inp.texcoord2.xyz, tmp5.xyz);
                tmp6.z = dot(inp.texcoord3.xyz, tmp5.xyz);
                tmp2.w = dot(-tmp2.xyz, tmp6.xyz);
                tmp2.w = tmp2.w + tmp2.w;
                tmp3.xyw = tmp6.xyz * -tmp2.www + -tmp2.xyz;
                tmp5 = texCUBE(_Cube, tmp3.xyw);
                tmp2.w = tmp4.w * tmp5.w;
                o.sv_target.w = tmp2.w * _Color.w + tmp3.z;
                tmp3.xyz = inp.texcoord4.yyy * unity_WorldToLight._m01_m11_m21;
                tmp3.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord4.xxx + tmp3.xyz;
                tmp3.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord4.zzz + tmp3.xyz;
                tmp3.xyz = tmp3.xyz + unity_WorldToLight._m03_m13_m23;
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
                tmp3.x = dot(tmp3.xyz, tmp3.xyz);
                tmp3 = tex2D(_LightTexture0, tmp3.xx);
                tmp2.w = tmp2.w * tmp3.x;
                tmp3.x = dot(tmp6.xyz, tmp6.xyz);
                tmp3.x = rsqrt(tmp3.x);
                tmp3.xyz = tmp3.xxx * tmp6.xyz;
                tmp5.xyz = tmp2.www * _LightColor0.xyz;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(tmp3.xyz, tmp1.xyz);
                tmp0.x = dot(tmp3.xyz, tmp0.xyz);
                tmp0.xw = max(tmp0.xw, float2(0.0, 0.0));
                tmp0.y = _Shininess * 128.0;
                tmp0.x = log(tmp0.x);
                tmp0.x = tmp0.x * tmp0.y;
                tmp0.x = exp(tmp0.x);
                tmp0.x = tmp1.w * tmp0.x;
                tmp1.xyz = tmp4.xyz * tmp5.xyz;
                tmp2.xyz = tmp5.xyz * _SpecColor.xyz;
                tmp0.xyz = tmp0.xxx * tmp2.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.www + tmp0.xyz;
                return o;
			}
			ENDCG
		}
	}
	Fallback "Transparent/VertexLit"
}