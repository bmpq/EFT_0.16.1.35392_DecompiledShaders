Shader "Decal/Water Deferred Decal" {
	Properties {
		[Header(Vertex Paint (A))] [Queue] _Color ("Main Color", Color) = (0,0,0,0.5)
		_SpecColor ("Specular Color", Color) = (0,0,0,0.95)
		_Smoothness ("Smoothness", Range(0, 1)) = 1
		_EmissionColor ("Emission", Color) = (0,0,0,0)
		_MainTex ("Mask (R)", 2D) = "white" {}
		_FadeStrength ("Fade Strength", Float) = 2
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_ReflectionStrength ("GI And Reflection Strength", Float) = 1
		_Fresnel ("Fresnel", Range(0, 1)) = 0.2
		_GIIntensity ("_GIIntensity", Range(0, 1)) = 1
		_CubemapColor ("Cubemap Color", Color) = (0,0,0,0)
		_RippleScale ("Ripple Scale", Float) = 1
		[Toggle(USERAIN)] _USERAIN ("Use rain (turn ripples on and water level is taken from rain intensity)", Float) = 1
		_EditorWaterLevel ("Water level (Use rain should be off)", Float) = 1
		_Temperature ("_Temperature", Vector) = (0.1,0.12,0.28,0)
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
			ColorMask RGB
			ZWrite Off
			GpuProgramID 39170
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
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _SpecColor;
			float4 _Color;
			float4 _EmissionColor;
			float _FadeStrength;
			float _Fresnel;
			float _GIIntensity;
			float4 _CubemapColor;
			float4 _Temperature;
			float _ThermalVisionOn;
			float _ReflectionStrength;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
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
                o.texcoord.zw = float2(0.0, 0.0);
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
                tmp3.xyz = tmp3.xyz * v.tangent.www;
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
                o.color.w = v.color.w * _EditorWaterLevel + -1.0;
                o.color.xyz = v.color.xyz;
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
                float4 tmp8;
                float4 tmp9;
                float4 tmp10;
                tmp0 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0.w = tmp0.x + inp.color.w;
                tmp0.w = saturate(tmp0.w * _FadeStrength);
                tmp0.xyz = tmp0.xyz * _Color.xyz;
                o.sv_target.w = tmp0.w * _Color.w;
                tmp1.x = inp.texcoord1.w;
                tmp1.y = inp.texcoord2.w;
                tmp1.z = inp.texcoord3.w;
                tmp2.xyz = _WorldSpaceCameraPos - tmp1.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp1.w = -tmp2.y * _Fresnel + 1.0;
                tmp1.w = tmp1.w * tmp1.w;
                tmp3.xyz = tmp1.www * _SpecColor.xyz;
                o.sv_target1.xyz = tmp0.www * tmp3.xyz;
                tmp2.w = tmp0.w * _SpecColor.w;
                tmp3.xyz = tmp2.yyy * float3(0.0, 2.0, 0.0) + -tmp2.xyz;
                o.sv_target3.w = tmp0.w * _EmissionColor.w;
                tmp3 = texCUBE(_Cube, tmp3.xyz);
                tmp3.xyz = tmp1.www * tmp3.xyz;
                tmp3.xyz = tmp3.xyz * _CubemapColor.xyz + _EmissionColor.xyz;
                tmp3.w = tmp2.w * _ReflectionStrength;
                tmp4.x = -_SpecColor.w * tmp0.w + 1.0;
                tmp4.y = dot(-tmp2.xyz, float3(0.0, 0.0, 1.0));
                tmp2.xyz = tmp4.yyy * float3(-0.0, -2.0, -0.0) + -tmp2.xyz;
                tmp4.y = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp4.y) {
                    tmp4.y = dot(tmp2.xyz, tmp2.xyz);
                    tmp4.y = rsqrt(tmp4.y);
                    tmp4.yzw = tmp2.xyz * tmp4.yyy;
                    tmp5.xyz = unity_SpecCube0_BoxMax.xyz - tmp1.xyz;
                    tmp5.xyz = tmp5.xyz / tmp4.yzw;
                    tmp6.xyz = unity_SpecCube0_BoxMin.xyz - tmp1.xyz;
                    tmp6.xyz = tmp6.xyz / tmp4.yzw;
                    tmp7.xyz = tmp4.yzw > float3(0.0, 0.0, 0.0);
                    tmp5.xyz = tmp7.xyz ? tmp5.xyz : tmp6.xyz;
                    tmp5.x = min(tmp5.y, tmp5.x);
                    tmp5.x = min(tmp5.z, tmp5.x);
                    tmp5.yzw = tmp1.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp4.yzw = tmp4.yzw * tmp5.xxx + tmp5.yzw;
                } else {
                    tmp4.yzw = tmp2.xyz;
                }
                tmp5.x = -tmp4.x * 0.7 + 1.7;
                tmp4.x = tmp4.x * tmp5.x;
                tmp4.x = tmp4.x * 6.0;
                tmp5 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp4.yzw, tmp4.x));
                tmp4.y = tmp5.w - 1.0;
                tmp4.y = unity_SpecCube0_HDR.w * tmp4.y + 1.0;
                tmp4.y = tmp4.y * unity_SpecCube0_HDR.x;
                tmp6.xyz = tmp5.xyz * tmp4.yyy;
                tmp4.z = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp4.z) {
                    tmp4.z = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp4.z) {
                        tmp4.z = dot(tmp2.xyz, tmp2.xyz);
                        tmp4.z = rsqrt(tmp4.z);
                        tmp7.xyz = tmp2.xyz * tmp4.zzz;
                        tmp8.xyz = unity_SpecCube1_BoxMax.xyz - tmp1.xyz;
                        tmp8.xyz = tmp8.xyz / tmp7.xyz;
                        tmp9.xyz = unity_SpecCube1_BoxMin.xyz - tmp1.xyz;
                        tmp9.xyz = tmp9.xyz / tmp7.xyz;
                        tmp10.xyz = tmp7.xyz > float3(0.0, 0.0, 0.0);
                        tmp8.xyz = tmp10.xyz ? tmp8.xyz : tmp9.xyz;
                        tmp4.z = min(tmp8.y, tmp8.x);
                        tmp4.z = min(tmp8.z, tmp4.z);
                        tmp1.xyz = tmp1.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp2.xyz = tmp7.xyz * tmp4.zzz + tmp1.xyz;
                    }
                    tmp7 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp2.xyz, tmp4.x));
                    tmp1.x = tmp7.w - 1.0;
                    tmp1.x = unity_SpecCube1_HDR.w * tmp1.x + 1.0;
                    tmp1.x = tmp1.x * unity_SpecCube1_HDR.x;
                    tmp1.xyz = tmp7.xyz * tmp1.xxx;
                    tmp2.xyz = tmp4.yyy * tmp5.xyz + -tmp1.xyz;
                    tmp6.xyz = unity_SpecCube0_BoxMin.www * tmp2.xyz + tmp1.xyz;
                }
                tmp1.xyz = tmp3.www * tmp6.xyz;
                tmp1.xyz = tmp1.www * tmp1.xyz;
                tmp1.xyz = tmp1.xyz * _GIIntensity.xxx + tmp3.xyz;
                o.sv_target3.xyz = exp(-tmp1.xyz);
                tmp1.x = _ThermalVisionOn > 0.0;
                tmp1.yzw = tmp0.xyz * _Temperature.zzz;
                tmp1.yzw = max(tmp1.yzw, _Temperature.xxx);
                tmp1.yzw = min(tmp1.yzw, _Temperature.yyy);
                tmp1.yzw = tmp1.yzw + _Temperature.www;
                o.sv_target.xyz = tmp1.xxx ? tmp1.yzw : tmp0.xyz;
                o.sv_target1.w = tmp2.w;
                o.sv_target2.xyz = float3(0.5, 1.0, 0.5);
                o.sv_target2.w = tmp0.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Blend Zero Zero, OneMinusDstAlpha One
			ColorMask A
			ZWrite Off
			GpuProgramID 85540
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
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _FadeStrength;
			float _Smoothness;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			
			// Keywords: 
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
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.texcoord.zw = float2(0.0, 0.0);
                o.texcoord1 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
                o.color.w = v.color.w * _EditorWaterLevel + -1.0;
                o.color.xyz = v.color.xyz;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                tmp0 = tex2D(_MainTex, inp.texcoord.xy);
                tmp0.x = tmp0.x + inp.color.w;
                tmp0.x = saturate(tmp0.x * _FadeStrength);
                o.sv_target1.w = tmp0.x * _Smoothness;
                o.sv_target1.xyz = float3(0.0, 0.0, 0.0);
                o.sv_target2 = float4(0.0, 0.0, 0.0, 0.0);
                o.sv_target3 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
	}
}