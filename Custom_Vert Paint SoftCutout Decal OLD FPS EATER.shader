Shader "Custom/Vert Paint SoftCutout Decal OLD FPS EATER" {
	Properties {
		[Queue] [Toggle(ALPHA_HEIGHT)] _AlphaHeight ("Alpha Height", Float) = 0
		_BlendStrength ("Blend Strength", Range(0.1, 30)) = 1
		_AlphaStrength ("Alpha Strength", Range(0.1, 30)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color0 ("Main Color 0", Color) = (1,1,1,1)
		_MainTex0 ("Base (RGB) Smoothness (A) 0", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap0 ("Normalmap 0", 2D) = "bump" {}
		_Smoothness0 ("Smoothness 0", Range(0, 1)) = 0
		_Specular0 ("Specular 0", Range(0, 1)) = 0
		_FresnelDiffuse0 ("Fresnel Diffuse 0", Range(0, 1)) = 0
		_FresnelSpecular0 ("Fresnel Specular 0", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color1 ("Main Color 0", Color) = (1,1,1,1)
		_MainTex1 ("Base (RGB) Smoothness (A) 1", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap1 ("Normalmap 1", 2D) = "bump" {}
		_Smoothness1 ("Smoothness 1", Range(0, 1)) = 0
		_Specular1 ("Specular 1", Range(0, 1)) = 0
		_FresnelDiffuse1 ("Fresnel Diffuse 1", Range(0, 1)) = 0
		_FresnelSpecular1 ("Fresnel Specular 1", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Color2 ("Main Color 0", Color) = (1,1,1,1)
		_MainTex2 ("Base (RGB) Smoothness (A) 2", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap2 ("Normalmap 2", 2D) = "bump" {}
		_Smoothness2 ("Smoothness 2", Range(0, 1)) = 0
		_Specular2 ("Specular 2", Range(0, 1)) = 0
		_FresnelDiffuse2 ("Fresnel Diffuse 2", Range(0, 1)) = 0
		_FresnelSpecular2 ("Fresnel Specular 2", Range(0, 1)) = 0
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _Heights ("Heights", 2D) = "white" {}
		_ReflectionStrength ("GI And Reflection Strength", Float) = 1
		_Cutoff ("_Cutoff", Float) = 0.85
		_Factor ("Z Offset Angle", Float) = 0
		_Units ("Z Offset Forward", Float) = 0
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 8858
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
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
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
			float4 _Heights_ST;
			float4 _MainTex0_ST;
			float4 _MainTex1_ST;
			float4 _MainTex2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _BlendStrength;
			float _AlphaStrength;
			float4 _Color0;
			float4 _Color1;
			float4 _Color2;
			float _FresnelDiffuse0;
			float _FresnelDiffuse1;
			float _FresnelDiffuse2;
			float _FresnelSpecular0;
			float _FresnelSpecular1;
			float _FresnelSpecular2;
			float _Specular0;
			float _Specular1;
			float _Specular2;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _ReflectionStrength;
			float _Cutoff;
			float4 _Temperature2;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _Heights;
			sampler2D _MainTex0;
			sampler2D _MainTex1;
			sampler2D _MainTex2;
			sampler2D _BumpMap0;
			sampler2D _BumpMap1;
			sampler2D _BumpMap2;
			
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
                o.texcoord4.xy = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.texcoord4.zw = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.texcoord5.xy = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
                o.texcoord5.zw = v.texcoord.xy * _Heights_ST.xy + _Heights_ST.zw;
                o.color = v.color;
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
                tmp0 = tex2D(_Heights, inp.texcoord4.xy);
                tmp1 = tex2D(_Heights, inp.texcoord4.zw);
                tmp2 = tex2D(_Heights, inp.texcoord5.xy);
                tmp3 = tex2D(_Heights, inp.texcoord5.zw);
                tmp2.x = tmp0.x;
                tmp2.y = tmp1.y;
                tmp0.xyz = tmp2.xyz * inp.color.xyz;
                tmp0.xyz = log(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * _BlendStrength.xxx;
                tmp0.xyz = exp(tmp0.xyz);
                tmp0.w = tmp0.y + tmp0.x;
                tmp0.w = tmp0.z + tmp0.w;
                tmp0.xyz = tmp0.xyz / tmp0.www;
                tmp0.w = tmp3.w + inp.color.w;
                tmp0.w = tmp0.w - 0.1;
                tmp0.w = log(tmp0.w);
                tmp0.w = tmp0.w * _AlphaStrength;
                tmp0.w = exp(tmp0.w);
                tmp1.w = min(tmp0.w, 1.0);
                tmp0.w = tmp1.w - _Cutoff;
                tmp0.w = tmp0.w > -0.0;
                if (tmp0.w) {
                    discard;
                }
                tmp2 = tex2D(_MainTex0, inp.texcoord4.xy);
                tmp2 = tmp2 * _Color0;
                tmp3 = tex2D(_MainTex1, inp.texcoord4.zw);
                tmp3 = tmp3 * _Color1;
                tmp3 = tmp0.yyyy * tmp3;
                tmp2 = tmp2 * tmp0.xxxx + tmp3;
                tmp3 = tex2D(_MainTex2, inp.texcoord5.xy);
                tmp3 = tmp3 * _Color2;
                tmp2 = tmp3 * tmp0.zzzz + tmp2;
                tmp3 = tex2D(_BumpMap0, inp.texcoord4.xy);
                tmp4 = tex2D(_BumpMap1, inp.texcoord4.zw);
                tmp4.xyz = tmp0.yyy * tmp4.xyw;
                tmp3.xyz = tmp3.xyw * tmp0.xxx + tmp4.xyz;
                tmp4 = tex2D(_BumpMap2, inp.texcoord5.xy);
                tmp3.yzw = tmp4.xyw * tmp0.zzz + tmp3.xyz;
                tmp3.x = tmp3.w * tmp3.y;
                tmp3.xy = tmp3.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp3.xy, tmp3.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp3.z = sqrt(tmp0.w);
                tmp4.x = dot(inp.texcoord1.xyz, tmp3.xyz);
                tmp4.y = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp4.z = dot(inp.texcoord3.xyz, tmp3.xyz);
                o.sv_target2.xyz = tmp4.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                tmp3.x = inp.texcoord1.w;
                tmp3.y = inp.texcoord2.w;
                tmp3.z = inp.texcoord3.w;
                tmp5.xyz = _WorldSpaceCameraPos - tmp3.xyz;
                tmp0.w = dot(tmp5.xyz, tmp5.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp5.xyz = tmp0.www * tmp5.xyz;
                tmp0.w = dot(tmp5.xyz, tmp4.xyz);
                tmp6.x = _FresnelSpecular0;
                tmp6.yz = float2(_FresnelSpecular1.x, _FresnelSpecular2.x);
                tmp6.x = dot(tmp0.xyz, tmp6.xyz);
                tmp6.y = dot(tmp0.xyz, float3(_FresnelDiffuse0.x, _FresnelDiffuse1.x, _FresnelDiffuse2.x));
                tmp6.xy = -tmp0.ww * tmp6.xy + float2(1.0, 1.0);
                tmp6.xy = tmp6.xy * tmp6.xy;
                tmp6.xy = tmp6.xy * tmp6.xy;
                tmp1.xyz = tmp2.xyz * tmp6.yyy;
                tmp0.w = dot(tmp0.xyz, float3(_Specular2.x, _Smoothness0.x, _Smoothness1.x));
                tmp2.xy = float2(_Specular0.x, _Specular1.x);
                tmp2.z = _Specular2;
                tmp0.x = dot(tmp0.xyz, tmp2.xyz);
                tmp0.x = tmp0.x * tmp2.w;
                tmp2.xyz = tmp6.xxx * tmp0.xxx;
                tmp2.w = tmp1.w - tmp0.w;
                tmp0.x = 1.0 - tmp0.w;
                tmp0.y = tmp2.z * _ReflectionStrength;
                tmp0.x = 1.0 - tmp0.x;
                tmp0.z = dot(-tmp5.xyz, tmp4.xyz);
                tmp0.z = tmp0.z + tmp0.z;
                tmp4.xyz = tmp4.xyz * -tmp0.zzz + -tmp5.xyz;
                tmp0.z = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp0.z) {
                    tmp0.z = dot(tmp4.xyz, tmp4.xyz);
                    tmp0.z = rsqrt(tmp0.z);
                    tmp5.xyz = tmp0.zzz * tmp4.xyz;
                    tmp6.yzw = unity_SpecCube0_BoxMax.xyz - tmp3.xyz;
                    tmp6.yzw = tmp6.yzw / tmp5.xyz;
                    tmp7.xyz = unity_SpecCube0_BoxMin.xyz - tmp3.xyz;
                    tmp7.xyz = tmp7.xyz / tmp5.xyz;
                    tmp8.xyz = tmp5.xyz > float3(0.0, 0.0, 0.0);
                    tmp6.yzw = tmp8.xyz ? tmp6.yzw : tmp7.xyz;
                    tmp0.z = min(tmp6.z, tmp6.y);
                    tmp0.z = min(tmp6.w, tmp0.z);
                    tmp6.yzw = tmp3.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp5.xyz = tmp5.xyz * tmp0.zzz + tmp6.yzw;
                } else {
                    tmp5.xyz = tmp4.xyz;
                }
                tmp0.z = -tmp0.x * 0.7 + 1.7;
                tmp0.x = tmp0.z * tmp0.x;
                tmp0.x = tmp0.x * 6.0;
                tmp5 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp5.xyz, tmp0.x));
                tmp0.z = tmp5.w - 1.0;
                tmp0.z = unity_SpecCube0_HDR.w * tmp0.z + 1.0;
                tmp0.z = tmp0.z * unity_SpecCube0_HDR.x;
                tmp6.yzw = tmp5.xyz * tmp0.zzz;
                tmp0.w = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp0.w) {
                    tmp0.w = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp0.w) {
                        tmp0.w = dot(tmp4.xyz, tmp4.xyz);
                        tmp0.w = rsqrt(tmp0.w);
                        tmp7.xyz = tmp0.www * tmp4.xyz;
                        tmp8.xyz = unity_SpecCube1_BoxMax.xyz - tmp3.xyz;
                        tmp8.xyz = tmp8.xyz / tmp7.xyz;
                        tmp9.xyz = unity_SpecCube1_BoxMin.xyz - tmp3.xyz;
                        tmp9.xyz = tmp9.xyz / tmp7.xyz;
                        tmp10.xyz = tmp7.xyz > float3(0.0, 0.0, 0.0);
                        tmp8.xyz = tmp10.xyz ? tmp8.xyz : tmp9.xyz;
                        tmp0.w = min(tmp8.y, tmp8.x);
                        tmp0.w = min(tmp8.z, tmp0.w);
                        tmp3.xyz = tmp3.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp4.xyz = tmp7.xyz * tmp0.www + tmp3.xyz;
                    }
                    tmp3 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp4.xyz, tmp0.x));
                    tmp0.x = tmp3.w - 1.0;
                    tmp0.x = unity_SpecCube1_HDR.w * tmp0.x + 1.0;
                    tmp0.x = tmp0.x * unity_SpecCube1_HDR.x;
                    tmp3.xyz = tmp3.xyz * tmp0.xxx;
                    tmp0.xzw = tmp0.zzz * tmp5.xyz + -tmp3.xyz;
                    tmp6.yzw = unity_SpecCube0_BoxMin.www * tmp0.xzw + tmp3.xyz;
                }
                tmp0.xyz = tmp0.yyy * tmp6.yzw;
                tmp0.xyz = tmp6.xxx * tmp0.xyz;
                o.sv_target3.xyz = exp(-tmp0.xyz);
                tmp0.x = _ThermalVisionOn > 0.0;
                tmp3 = tmp1 * _Temperature2;
                tmp3 = max(tmp3, _Temperature2);
                tmp3 = min(tmp3, _Temperature2);
                tmp3 = tmp3 + _Temperature2;
                tmp4 = tmp2.zzzw * _Temperature2;
                tmp4 = max(tmp4, _Temperature2);
                tmp4 = min(tmp4, _Temperature2);
                o.sv_target = tmp0.xxxx ? tmp3 : tmp1;
                o.sv_target1 = tmp0.xxxx ? tmp4 : tmp2;
                o.sv_target2.w = tmp1.w;
                o.sv_target3.w = tmp1.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
			ZWrite Off
			GpuProgramID 67649
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
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
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
			float4 _Heights_ST;
			float4 _MainTex0_ST;
			float4 _MainTex1_ST;
			float4 _MainTex2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _BlendStrength;
			float _AlphaStrength;
			float4 _Color0;
			float4 _Color1;
			float4 _Color2;
			float _FresnelDiffuse0;
			float _FresnelDiffuse1;
			float _FresnelDiffuse2;
			float _FresnelSpecular0;
			float _FresnelSpecular1;
			float _FresnelSpecular2;
			float _Specular0;
			float _Specular1;
			float _Specular2;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _ReflectionStrength;
			float _Cutoff;
			float4 _Temperature2;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _Heights;
			sampler2D _MainTex0;
			sampler2D _MainTex1;
			sampler2D _MainTex2;
			sampler2D _BumpMap0;
			sampler2D _BumpMap1;
			sampler2D _BumpMap2;
			
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
                o.texcoord4.xy = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.texcoord4.zw = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.texcoord5.xy = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
                o.texcoord5.zw = v.texcoord.xy * _Heights_ST.xy + _Heights_ST.zw;
                o.color = v.color;
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
                tmp0 = tex2D(_Heights, inp.texcoord4.xy);
                tmp1 = tex2D(_Heights, inp.texcoord4.zw);
                tmp2 = tex2D(_Heights, inp.texcoord5.xy);
                tmp3 = tex2D(_Heights, inp.texcoord5.zw);
                tmp2.x = tmp0.x;
                tmp2.y = tmp1.y;
                tmp0.xyz = tmp2.xyz * inp.color.xyz;
                tmp0.xyz = log(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * _BlendStrength.xxx;
                tmp0.xyz = exp(tmp0.xyz);
                tmp0.w = tmp0.y + tmp0.x;
                tmp0.w = tmp0.z + tmp0.w;
                tmp0.xyz = tmp0.xyz / tmp0.www;
                tmp0.w = tmp3.w + inp.color.w;
                tmp0.w = tmp0.w - 0.1;
                tmp0.w = log(tmp0.w);
                tmp0.w = tmp0.w * _AlphaStrength;
                tmp0.w = exp(tmp0.w);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = tmp0.w - _Cutoff;
                tmp0.w = tmp0.w < 0.0;
                if (tmp0.w) {
                    discard;
                }
                tmp1 = tex2D(_MainTex0, inp.texcoord4.xy);
                tmp1 = tmp1 * _Color0;
                tmp2 = tex2D(_MainTex1, inp.texcoord4.zw);
                tmp2 = tmp2 * _Color1;
                tmp2 = tmp0.yyyy * tmp2;
                tmp1 = tmp1 * tmp0.xxxx + tmp2;
                tmp2 = tex2D(_MainTex2, inp.texcoord5.xy);
                tmp2 = tmp2 * _Color2;
                tmp1 = tmp2 * tmp0.zzzz + tmp1;
                tmp2 = tex2D(_BumpMap0, inp.texcoord4.xy);
                tmp3 = tex2D(_BumpMap1, inp.texcoord4.zw);
                tmp3.xyz = tmp0.yyy * tmp3.xyw;
                tmp2.xyz = tmp2.xyw * tmp0.xxx + tmp3.xyz;
                tmp3 = tex2D(_BumpMap2, inp.texcoord5.xy);
                tmp2.yzw = tmp3.xyw * tmp0.zzz + tmp2.xyz;
                tmp2.x = tmp2.w * tmp2.y;
                tmp2.xy = tmp2.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
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
                tmp5.x = _FresnelSpecular0;
                tmp5.yz = float2(_FresnelSpecular1.x, _FresnelSpecular2.x);
                tmp5.x = dot(tmp0.xyz, tmp5.xyz);
                tmp5.y = dot(tmp0.xyz, float3(_FresnelDiffuse0.x, _FresnelDiffuse1.x, _FresnelDiffuse2.x));
                tmp5.xy = -tmp0.ww * tmp5.xy + float2(1.0, 1.0);
                tmp5.xy = tmp5.xy * tmp5.xy;
                tmp5.xy = tmp5.xy * tmp5.xy;
                tmp6.xyz = tmp1.xyz * tmp5.yyy;
                tmp0.w = dot(tmp0.xyz, float3(_Specular2.x, _Smoothness0.x, _Smoothness1.x));
                tmp1.xy = float2(_Specular0.x, _Specular1.x);
                tmp1.z = _Specular2;
                tmp0.x = dot(tmp0.xyz, tmp1.xyz);
                tmp0.x = tmp0.x * tmp1.w;
                tmp1.xyz = tmp5.xxx * tmp0.xxx;
                tmp1.w = 1.0 - tmp0.w;
                tmp0.x = tmp1.z * _ReflectionStrength;
                tmp0.y = 1.0 - tmp1.w;
                tmp0.z = dot(-tmp4.xyz, tmp3.xyz);
                tmp0.z = tmp0.z + tmp0.z;
                tmp3.xyz = tmp3.xyz * -tmp0.zzz + -tmp4.xyz;
                tmp0.z = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp0.z) {
                    tmp0.z = dot(tmp3.xyz, tmp3.xyz);
                    tmp0.z = rsqrt(tmp0.z);
                    tmp4.xyz = tmp0.zzz * tmp3.xyz;
                    tmp5.yzw = unity_SpecCube0_BoxMax.xyz - tmp2.xyz;
                    tmp5.yzw = tmp5.yzw / tmp4.xyz;
                    tmp7.xyz = unity_SpecCube0_BoxMin.xyz - tmp2.xyz;
                    tmp7.xyz = tmp7.xyz / tmp4.xyz;
                    tmp8.xyz = tmp4.xyz > float3(0.0, 0.0, 0.0);
                    tmp5.yzw = tmp8.xyz ? tmp5.yzw : tmp7.xyz;
                    tmp0.z = min(tmp5.z, tmp5.y);
                    tmp0.z = min(tmp5.w, tmp0.z);
                    tmp5.yzw = tmp2.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp4.xyz = tmp4.xyz * tmp0.zzz + tmp5.yzw;
                } else {
                    tmp4.xyz = tmp3.xyz;
                }
                tmp0.z = -tmp0.y * 0.7 + 1.7;
                tmp0.y = tmp0.z * tmp0.y;
                tmp0.y = tmp0.y * 6.0;
                tmp4 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp4.xyz, tmp0.y));
                tmp0.z = tmp4.w - 1.0;
                tmp0.z = unity_SpecCube0_HDR.w * tmp0.z + 1.0;
                tmp0.z = tmp0.z * unity_SpecCube0_HDR.x;
                tmp5.yzw = tmp4.xyz * tmp0.zzz;
                tmp0.w = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp0.w) {
                    tmp0.w = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp0.w) {
                        tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                        tmp0.w = rsqrt(tmp0.w);
                        tmp7.xyz = tmp0.www * tmp3.xyz;
                        tmp8.xyz = unity_SpecCube1_BoxMax.xyz - tmp2.xyz;
                        tmp8.xyz = tmp8.xyz / tmp7.xyz;
                        tmp9.xyz = unity_SpecCube1_BoxMin.xyz - tmp2.xyz;
                        tmp9.xyz = tmp9.xyz / tmp7.xyz;
                        tmp10.xyz = tmp7.xyz > float3(0.0, 0.0, 0.0);
                        tmp8.xyz = tmp10.xyz ? tmp8.xyz : tmp9.xyz;
                        tmp0.w = min(tmp8.y, tmp8.x);
                        tmp0.w = min(tmp8.z, tmp0.w);
                        tmp2.xyz = tmp2.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp3.xyz = tmp7.xyz * tmp0.www + tmp2.xyz;
                    }
                    tmp2 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp3.xyz, tmp0.y));
                    tmp0.y = tmp2.w - 1.0;
                    tmp0.y = unity_SpecCube1_HDR.w * tmp0.y + 1.0;
                    tmp0.y = tmp0.y * unity_SpecCube1_HDR.x;
                    tmp2.xyz = tmp2.xyz * tmp0.yyy;
                    tmp0.yzw = tmp0.zzz * tmp4.xyz + -tmp2.xyz;
                    tmp5.yzw = unity_SpecCube0_BoxMin.www * tmp0.yzw + tmp2.xyz;
                }
                tmp0.xyz = tmp0.xxx * tmp5.yzw;
                tmp0.xyz = tmp5.xxx * tmp0.xyz;
                o.sv_target3.xyz = exp(-tmp0.xyz);
                tmp0.x = _ThermalVisionOn > 0.0;
                tmp6.w = 1.0;
                tmp2 = tmp6 * _Temperature2;
                tmp2 = max(tmp2, _Temperature2);
                tmp2 = min(tmp2, _Temperature2);
                tmp2 = tmp2 + _Temperature2;
                tmp3 = tmp1.zzzw * _Temperature2;
                tmp3 = max(tmp3, _Temperature2);
                tmp3 = min(tmp3, _Temperature2);
                o.sv_target = tmp0.xxxx ? tmp2 : tmp6;
                o.sv_target1 = tmp0.xxxx ? tmp3 : tmp1;
                o.sv_target2.w = 1.0;
                o.sv_target3.w = 1.0;
                return o;
			}
			ENDCG
		}
	}
	Fallback "Hidden/Internal-BlackError"
}