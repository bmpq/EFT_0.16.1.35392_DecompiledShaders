Shader "p0/SoftCutoutBumpedFresnelDeferred" {
	Properties {
		[Queue] _Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		[NoScaleOffset] _SpecularMap ("Specular (RGB)", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap ("Normalmap", 2D) = "bump" {}
		_AddAlpha ("Add Alpha", Range(-1, 1)) = 0
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_DefVals ("Defuse Vals", Vector) = (0.1,2.5,0,0)
		_Smoothness ("Smoothness", Range(0, 1)) = 0
		_Specular ("Specular", Range(0, 1)) = 0
		_ReflectionStrength ("GI And Reflection Strength", Float) = 1
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature ("_Temperature(min, max, factor)", Vector) = (0.1,0.3,0.3,0)
	}
	SubShader {
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 530
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float2 texcoord4 : TEXCOORD4;
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
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _AddAlpha;
			float _Cutoff;
			float4 _Color;
			float3 _DefVals;
			float _Smoothness;
			float _Specular;
			float _ReflectionStrength;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _SpecularMap;
			
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
                o.texcoord4.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.color = float4(0.0, 0.0, 0.0, 0.0);
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
                float4 tmp11;
                tmp0 = tex2D(_MainTex, inp.texcoord4.xy);
                tmp0.xyz = tmp0.xyz * _Color.xyz;
                tmp1.w = tmp0.w * _Color.w + _AddAlpha;
                tmp0.w = tmp1.w - _Cutoff;
                tmp0.w = tmp0.w > -0.0;
                if (tmp0.w) {
                    discard;
                }
                tmp2 = tex2D(_BumpMap, inp.texcoord4.xy);
                tmp2.x = tmp2.w * tmp2.x;
                tmp2.xy = tmp2.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp2.xy, tmp2.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp2.z = sqrt(tmp0.w);
                tmp3.x = dot(inp.texcoord1.xyz, tmp2.xyz);
                tmp3.y = dot(inp.texcoord2.xyz, tmp2.xyz);
                tmp3.z = dot(inp.texcoord3.xyz, tmp2.xyz);
                o.sv_target2.xyz = tmp3.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                tmp2.x = inp.texcoord1.w;
                tmp2.y = inp.texcoord2.w;
                tmp2.z = inp.texcoord3.w;
                tmp4.xyz = _WorldSpaceCameraPos - tmp2.xyz;
                tmp0.w = dot(tmp4.xyz, tmp4.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp4.xyz = tmp0.www * tmp4.xyz;
                tmp0.w = dot(tmp4.xyz, tmp3.xyz);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.w = tmp0.w * tmp0.w;
                tmp2.w = _DefVals.y * tmp0.w + _DefVals.x;
                tmp1.xyz = tmp0.xyz * tmp2.www;
                tmp5 = tex2D(_SpecularMap, inp.texcoord4.xy);
                tmp0.xyz = tmp5.xyz * _Specular.xxx;
                tmp5.xyz = tmp0.www * tmp0.xyz;
                tmp5.w = tmp1.w - _Smoothness;
                tmp0.x = 1.0 - _Smoothness;
                tmp6.xyz = tmp5.xyz * _ReflectionStrength.xxx;
                tmp0.x = 1.0 - tmp0.x;
                tmp0.y = dot(-tmp4.xyz, tmp3.xyz);
                tmp0.y = tmp0.y + tmp0.y;
                tmp3.xyz = tmp3.xyz * -tmp0.yyy + -tmp4.xyz;
                tmp0.y = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp0.y) {
                    tmp0.y = dot(tmp3.xyz, tmp3.xyz);
                    tmp0.y = rsqrt(tmp0.y);
                    tmp4.xyz = tmp0.yyy * tmp3.xyz;
                    tmp7.xyz = unity_SpecCube0_BoxMax.xyz - tmp2.xyz;
                    tmp7.xyz = tmp7.xyz / tmp4.xyz;
                    tmp8.xyz = unity_SpecCube0_BoxMin.xyz - tmp2.xyz;
                    tmp8.xyz = tmp8.xyz / tmp4.xyz;
                    tmp9.xyz = tmp4.xyz > float3(0.0, 0.0, 0.0);
                    tmp7.xyz = tmp9.xyz ? tmp7.xyz : tmp8.xyz;
                    tmp0.y = min(tmp7.y, tmp7.x);
                    tmp0.y = min(tmp7.z, tmp0.y);
                    tmp7.xyz = tmp2.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp4.xyz = tmp4.xyz * tmp0.yyy + tmp7.xyz;
                } else {
                    tmp4.xyz = tmp3.xyz;
                }
                tmp0.y = -tmp0.x * 0.7 + 1.7;
                tmp0.x = tmp0.y * tmp0.x;
                tmp0.x = tmp0.x * 6.0;
                tmp4 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp4.xyz, tmp0.x));
                tmp0.y = tmp4.w - 1.0;
                tmp0.y = unity_SpecCube0_HDR.w * tmp0.y + 1.0;
                tmp0.y = tmp0.y * unity_SpecCube0_HDR.x;
                tmp7.xyz = tmp4.xyz * tmp0.yyy;
                tmp0.z = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp0.z) {
                    tmp0.z = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp0.z) {
                        tmp0.z = dot(tmp3.xyz, tmp3.xyz);
                        tmp0.z = rsqrt(tmp0.z);
                        tmp8.xyz = tmp0.zzz * tmp3.xyz;
                        tmp9.xyz = unity_SpecCube1_BoxMax.xyz - tmp2.xyz;
                        tmp9.xyz = tmp9.xyz / tmp8.xyz;
                        tmp10.xyz = unity_SpecCube1_BoxMin.xyz - tmp2.xyz;
                        tmp10.xyz = tmp10.xyz / tmp8.xyz;
                        tmp11.xyz = tmp8.xyz > float3(0.0, 0.0, 0.0);
                        tmp9.xyz = tmp11.xyz ? tmp9.xyz : tmp10.xyz;
                        tmp0.z = min(tmp9.y, tmp9.x);
                        tmp0.z = min(tmp9.z, tmp0.z);
                        tmp2.xyz = tmp2.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp3.xyz = tmp8.xyz * tmp0.zzz + tmp2.xyz;
                    }
                    tmp2 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp3.xyz, tmp0.x));
                    tmp0.x = tmp2.w - 1.0;
                    tmp0.x = unity_SpecCube1_HDR.w * tmp0.x + 1.0;
                    tmp0.x = tmp0.x * unity_SpecCube1_HDR.x;
                    tmp2.xyz = tmp2.xyz * tmp0.xxx;
                    tmp0.xyz = tmp0.yyy * tmp4.xyz + -tmp2.xyz;
                    tmp7.xyz = unity_SpecCube0_BoxMin.www * tmp0.xyz + tmp2.xyz;
                }
                tmp0.xyz = tmp6.xyz * tmp7.xyz;
                tmp0.xyz = tmp0.www * tmp0.xyz;
                o.sv_target3.xyz = exp(-tmp0.xyz);
                tmp0.x = _ThermalVisionOn > 0.0;
                tmp2 = tmp1 * _Temperature;
                tmp2 = max(tmp2, _Temperature);
                tmp2 = min(tmp2, _Temperature);
                tmp2 = tmp2 + _Temperature;
                tmp3 = tmp5 * _Temperature;
                tmp3 = max(tmp3, _Temperature);
                tmp3 = min(tmp3, _Temperature);
                o.sv_target = tmp0.xxxx ? tmp2 : tmp1;
                o.sv_target1 = tmp0.xxxx ? tmp3 : tmp5;
                o.sv_target2.w = tmp1.w;
                o.sv_target3.w = tmp1.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Stencil {
				WriteMask 3
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 102036
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float2 texcoord4 : TEXCOORD4;
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
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _AddAlpha;
			float _Cutoff;
			float4 _Color;
			float3 _DefVals;
			float _Smoothness;
			float _Specular;
			float _ReflectionStrength;
			float4 _Temperature;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _SpecularMap;
			
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
                o.texcoord4.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.color = float4(0.0, 0.0, 0.0, 0.0);
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
                tmp0 = tex2D(_MainTex, inp.texcoord4.xy);
                tmp0.xyz = tmp0.xyz * _Color.xyz;
                tmp0.w = tmp0.w * _Color.w + _AddAlpha;
                tmp0.w = tmp0.w - _Cutoff;
                tmp0.w = tmp0.w < 0.0;
                if (tmp0.w) {
                    discard;
                }
                tmp1 = tex2D(_BumpMap, inp.texcoord4.xy);
                tmp1.x = tmp1.w * tmp1.x;
                tmp1.xy = tmp1.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp1.xy, tmp1.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp1.z = sqrt(tmp0.w);
                tmp2.x = dot(inp.texcoord1.xyz, tmp1.xyz);
                tmp2.y = dot(inp.texcoord2.xyz, tmp1.xyz);
                tmp2.z = dot(inp.texcoord3.xyz, tmp1.xyz);
                o.sv_target2.xyz = tmp2.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                tmp1.x = inp.texcoord1.w;
                tmp1.y = inp.texcoord2.w;
                tmp1.z = inp.texcoord3.w;
                tmp3.xyz = _WorldSpaceCameraPos - tmp1.xyz;
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = dot(tmp3.xyz, tmp2.xyz);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.w = tmp0.w * tmp0.w;
                tmp1.w = _DefVals.y * tmp0.w + _DefVals.x;
                tmp4.xyz = tmp0.xyz * tmp1.www;
                tmp5 = tex2D(_SpecularMap, inp.texcoord4.xy);
                tmp0.xyz = tmp5.xyz * _Specular.xxx;
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1.w = 1.0 - _Smoothness;
                tmp5.xyz = tmp0.xyz * _ReflectionStrength.xxx;
                tmp2.w = 1.0 - tmp1.w;
                tmp3.w = dot(-tmp3.xyz, tmp2.xyz);
                tmp3.w = tmp3.w + tmp3.w;
                tmp2.xyz = tmp2.xyz * -tmp3.www + -tmp3.xyz;
                tmp3.x = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp3.x) {
                    tmp3.x = dot(tmp2.xyz, tmp2.xyz);
                    tmp3.x = rsqrt(tmp3.x);
                    tmp3.xyz = tmp2.xyz * tmp3.xxx;
                    tmp6.xyz = unity_SpecCube0_BoxMax.xyz - tmp1.xyz;
                    tmp6.xyz = tmp6.xyz / tmp3.xyz;
                    tmp7.xyz = unity_SpecCube0_BoxMin.xyz - tmp1.xyz;
                    tmp7.xyz = tmp7.xyz / tmp3.xyz;
                    tmp8.xyz = tmp3.xyz > float3(0.0, 0.0, 0.0);
                    tmp6.xyz = tmp8.xyz ? tmp6.xyz : tmp7.xyz;
                    tmp3.w = min(tmp6.y, tmp6.x);
                    tmp3.w = min(tmp6.z, tmp3.w);
                    tmp6.xyz = tmp1.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp3.xyz = tmp3.xyz * tmp3.www + tmp6.xyz;
                } else {
                    tmp3.xyz = tmp2.xyz;
                }
                tmp3.w = -tmp2.w * 0.7 + 1.7;
                tmp2.w = tmp2.w * tmp3.w;
                tmp2.w = tmp2.w * 6.0;
                tmp3 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp3.xyz, tmp2.w));
                tmp3.w = tmp3.w - 1.0;
                tmp3.w = unity_SpecCube0_HDR.w * tmp3.w + 1.0;
                tmp3.w = tmp3.w * unity_SpecCube0_HDR.x;
                tmp6.xyz = tmp3.xyz * tmp3.www;
                tmp5.w = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp5.w) {
                    tmp5.w = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp5.w) {
                        tmp5.w = dot(tmp2.xyz, tmp2.xyz);
                        tmp5.w = rsqrt(tmp5.w);
                        tmp7.xyz = tmp2.xyz * tmp5.www;
                        tmp8.xyz = unity_SpecCube1_BoxMax.xyz - tmp1.xyz;
                        tmp8.xyz = tmp8.xyz / tmp7.xyz;
                        tmp9.xyz = unity_SpecCube1_BoxMin.xyz - tmp1.xyz;
                        tmp9.xyz = tmp9.xyz / tmp7.xyz;
                        tmp10.xyz = tmp7.xyz > float3(0.0, 0.0, 0.0);
                        tmp8.xyz = tmp10.xyz ? tmp8.xyz : tmp9.xyz;
                        tmp5.w = min(tmp8.y, tmp8.x);
                        tmp5.w = min(tmp8.z, tmp5.w);
                        tmp1.xyz = tmp1.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp2.xyz = tmp7.xyz * tmp5.www + tmp1.xyz;
                    }
                    tmp2 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp2.xyz, tmp2.w));
                    tmp1.x = tmp2.w - 1.0;
                    tmp1.x = unity_SpecCube1_HDR.w * tmp1.x + 1.0;
                    tmp1.x = tmp1.x * unity_SpecCube1_HDR.x;
                    tmp1.xyz = tmp2.xyz * tmp1.xxx;
                    tmp2.xyz = tmp3.www * tmp3.xyz + -tmp1.xyz;
                    tmp6.xyz = unity_SpecCube0_BoxMin.www * tmp2.xyz + tmp1.xyz;
                }
                tmp1.xyz = tmp5.xyz * tmp6.xyz;
                tmp1.xyz = tmp0.www * tmp1.xyz;
                o.sv_target3.xyz = exp(-tmp1.xyz);
                tmp0.w = _ThermalVisionOn > 0.0;
                tmp4.w = 1.0;
                tmp2 = tmp4 * _Temperature;
                tmp2 = max(tmp2, _Temperature);
                tmp2 = min(tmp2, _Temperature);
                tmp2 = tmp2 + _Temperature;
                tmp3.xyz = tmp0.xyz * _Temperature.zzz;
                tmp3.w = tmp1.w * _Temperature.z;
                tmp3 = max(tmp3, _Temperature);
                tmp3 = min(tmp3, _Temperature);
                o.sv_target = tmp0.wwww ? tmp2 : tmp4;
                o.sv_target1.xyz = tmp0.www ? tmp3.xyz : tmp0.xyz;
                o.sv_target1.w = tmp0.w ? tmp3.w : tmp1.w;
                o.sv_target2.w = 1.0;
                o.sv_target3.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			GpuProgramID 134643
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float2 texcoord4 : TEXCOORD4;
				float4 color : COLOR0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
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
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp0.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
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
                o.texcoord4.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.color = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.145098, 0.5882353, 0.7450981, 1.0);
                return o;
			}
			ENDCG
		}
	}
	Fallback "p0/SoftCutoutBumpedFresnel"
}