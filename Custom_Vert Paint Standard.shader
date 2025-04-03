Shader "Custom/Vert Paint Standard" {
	Properties {
		_BlendStrength ("Blend Strength", Range(0.1, 30)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex0 ("Base (RGB) Smoothness (A) 0", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap0 ("Normalmap 0", 2D) = "bump" {}
		[Gamma] _Metallic0 ("Metallic 0", Range(0, 1)) = 0
		_Smoothness0 ("Smoothness 0", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex1 ("Base (RGB) Smoothness (A) 1", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap1 ("Normalmap 1", 2D) = "bump" {}
		[Gamma] _Metallic1 ("Metallic 1", Range(0, 1)) = 0
		_Smoothness1 ("Smoothness 1", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] _MainTex2 ("Base (RGB) Smoothness (A) 2", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap2 ("Normalmap 2", 2D) = "bump" {}
		[Gamma] _Metallic2 ("Metallic 2", Range(0, 1)) = 0
		_Smoothness2 ("Smoothness 2", Range(0, 1)) = 1
		[Space(30)] [Header(________________________________________________________________________________________________________________)] [NoScaleOffset] _Heights ("Heights", 2D) = "white" {}
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.5,0.4,0)
	}
	SubShader {
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
			GpuProgramID 38826
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
				float4 color : COLOR0;
				float4 texcoord7 : TEXCOORD7;
				float4 texcoord8 : TEXCOORD8;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex0_ST;
			float4 _MainTex1_ST;
			float4 _MainTex2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float _BlendStrength;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
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
                o.texcoord.xy = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
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
                o.texcoord3.x = tmp2.x;
                o.texcoord4.x = tmp2.y;
                o.texcoord3.z = tmp1.z;
                o.texcoord4.z = tmp1.x;
                o.texcoord3.w = tmp0.y;
                o.texcoord4.w = tmp0.z;
                o.texcoord3.y = tmp3.y;
                o.texcoord4.y = tmp3.z;
                o.color = v.color;
                o.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
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
                float4 tmp10;
                float4 tmp11;
                float4 tmp12;
                tmp0.x = inp.texcoord2.w;
                tmp0.y = inp.texcoord3.w;
                tmp0.z = inp.texcoord4.w;
                tmp1.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp1.xyz;
                tmp3 = tex2D(_Heights, inp.texcoord.xy);
                tmp4 = tex2D(_Heights, inp.texcoord.zw);
                tmp5 = tex2D(_Heights, inp.texcoord1.xy);
                tmp5.x = tmp3.x;
                tmp5.y = tmp4.y;
                tmp3.xyz = tmp5.xyz * inp.color.xyz;
                tmp3.xyz = log(tmp3.xyz);
                tmp3.xyz = tmp3.xyz * _BlendStrength.xxx;
                tmp3.xyz = exp(tmp3.xyz);
                tmp1.w = tmp3.y + tmp3.x;
                tmp1.w = tmp3.z + tmp1.w;
                tmp3.xyz = tmp3.xyz / tmp1.www;
                tmp4 = tex2D(_MainTex0, inp.texcoord.xy);
                tmp5 = tex2D(_MainTex1, inp.texcoord.zw);
                tmp5 = tmp3.yyyy * tmp5;
                tmp4 = tmp4 * tmp3.xxxx + tmp5;
                tmp5 = tex2D(_MainTex2, inp.texcoord1.xy);
                tmp4 = tmp5 * tmp3.zzzz + tmp4;
                tmp1.w = dot(tmp3.xyz, float3(_Smoothness0.x, _Smoothness1.x, _Smoothness2.x));
                tmp4.w = tmp1.w * tmp4.w;
                tmp1.w = dot(tmp3.xyz, float3(_BlendStrength.x, _Metallic0.x, _Metallic1.x));
                tmp5 = tex2D(_BumpMap0, inp.texcoord.xy);
                tmp6 = tex2D(_BumpMap1, inp.texcoord.zw);
                tmp6.xyz = tmp3.yyy * tmp6.xyw;
                tmp3.xyw = tmp5.xyw * tmp3.xxx + tmp6.xyz;
                tmp5 = tex2D(_BumpMap2, inp.texcoord1.xy);
                tmp3.yzw = tmp5.xyw * tmp3.zzz + tmp3.xyw;
                tmp3.x = tmp3.w * tmp3.y;
                tmp3.xy = tmp3.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp3.xy, tmp3.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp3.z = sqrt(tmp2.w);
                tmp2.w = _ThermalVisionOn > 0.0;
                tmp5.xyz = tmp4.xyz * _Temperature2.zzz;
                tmp5.xyz = max(tmp5.xyz, _Temperature2.xxx);
                tmp5.xyz = min(tmp5.xyz, _Temperature2.yyy);
                tmp5.xyz = tmp5.xyz + _Temperature2.www;
                tmp3.w = tmp4.w * _Temperature2.z;
                tmp3.w = max(tmp3.w, _Temperature2.x);
                tmp5.w = min(tmp3.w, _Temperature2.y);
                tmp4 = tmp2.wwww ? tmp5 : tmp4;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord3.www * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.www + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord4.www + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp5.xyz = tmp2.www ? tmp5.xyz : tmp0.xyz;
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
                tmp5.x = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp5.y = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp5.z = dot(inp.texcoord4.xyz, tmp3.xyz);
                tmp3.x = dot(tmp5.xyz, tmp5.xyz);
                tmp3.x = rsqrt(tmp3.x);
                tmp3.xyz = tmp3.xxx * tmp5.xyz;
                tmp3.w = 1.0 - tmp4.w;
                tmp5.x = dot(-tmp2.xyz, tmp3.xyz);
                tmp5.x = tmp5.x + tmp5.x;
                tmp5.xyz = tmp3.xyz * -tmp5.xxx + -tmp2.xyz;
                tmp6.xyz = tmp2.www * _LightColor0.xyz;
                tmp2.w = unity_SpecCube0_ProbePosition.w > 0.0;
                if (tmp2.w) {
                    tmp2.w = dot(tmp5.xyz, tmp5.xyz);
                    tmp2.w = rsqrt(tmp2.w);
                    tmp7.xyz = tmp2.www * tmp5.xyz;
                    tmp8.xyz = unity_SpecCube0_BoxMax.xyz - tmp0.xyz;
                    tmp8.xyz = tmp8.xyz / tmp7.xyz;
                    tmp9.xyz = unity_SpecCube0_BoxMin.xyz - tmp0.xyz;
                    tmp9.xyz = tmp9.xyz / tmp7.xyz;
                    tmp10.xyz = tmp7.xyz > float3(0.0, 0.0, 0.0);
                    tmp8.xyz = tmp10.xyz ? tmp8.xyz : tmp9.xyz;
                    tmp2.w = min(tmp8.y, tmp8.x);
                    tmp2.w = min(tmp8.z, tmp2.w);
                    tmp8.xyz = tmp0.xyz - unity_SpecCube0_ProbePosition.xyz;
                    tmp7.xyz = tmp7.xyz * tmp2.www + tmp8.xyz;
                } else {
                    tmp7.xyz = tmp5.xyz;
                }
                tmp2.w = -tmp3.w * 0.7 + 1.7;
                tmp2.w = tmp2.w * tmp3.w;
                tmp2.w = tmp2.w * 6.0;
                tmp7 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp7.xyz, tmp2.w));
                tmp5.w = tmp7.w - 1.0;
                tmp5.w = unity_SpecCube0_HDR.w * tmp5.w + 1.0;
                tmp5.w = tmp5.w * unity_SpecCube0_HDR.x;
                tmp8.xyz = tmp7.xyz * tmp5.www;
                tmp6.w = unity_SpecCube0_BoxMin.w < 0.99999;
                if (tmp6.w) {
                    tmp6.w = unity_SpecCube1_ProbePosition.w > 0.0;
                    if (tmp6.w) {
                        tmp6.w = dot(tmp5.xyz, tmp5.xyz);
                        tmp6.w = rsqrt(tmp6.w);
                        tmp9.xyz = tmp5.xyz * tmp6.www;
                        tmp10.xyz = unity_SpecCube1_BoxMax.xyz - tmp0.xyz;
                        tmp10.xyz = tmp10.xyz / tmp9.xyz;
                        tmp11.xyz = unity_SpecCube1_BoxMin.xyz - tmp0.xyz;
                        tmp11.xyz = tmp11.xyz / tmp9.xyz;
                        tmp12.xyz = tmp9.xyz > float3(0.0, 0.0, 0.0);
                        tmp10.xyz = tmp12.xyz ? tmp10.xyz : tmp11.xyz;
                        tmp6.w = min(tmp10.y, tmp10.x);
                        tmp6.w = min(tmp10.z, tmp6.w);
                        tmp0.xyz = tmp0.xyz - unity_SpecCube1_ProbePosition.xyz;
                        tmp5.xyz = tmp9.xyz * tmp6.www + tmp0.xyz;
                    }
                    tmp9 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp5.xyz, tmp2.w));
                    tmp0.x = tmp9.w - 1.0;
                    tmp0.x = unity_SpecCube1_HDR.w * tmp0.x + 1.0;
                    tmp0.x = tmp0.x * unity_SpecCube1_HDR.x;
                    tmp0.xyz = tmp9.xyz * tmp0.xxx;
                    tmp5.xyz = tmp5.www * tmp7.xyz + -tmp0.xyz;
                    tmp8.xyz = unity_SpecCube0_BoxMin.www * tmp5.xyz + tmp0.xyz;
                }
                tmp0.xyz = tmp4.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                tmp0.xyz = tmp1.www * tmp0.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp1.w = -tmp1.w * 0.7790837 + 0.7790837;
                tmp4.xyz = tmp1.www * tmp4.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.www + _WorldSpaceLightPos0.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = max(tmp0.w, 0.001);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp0.w = dot(tmp3.xyz, tmp2.xyz);
                tmp2.x = saturate(dot(tmp3.xyz, _WorldSpaceLightPos0.xyz));
                tmp2.y = saturate(dot(tmp3.xyz, tmp1.xyz));
                tmp1.x = saturate(dot(_WorldSpaceLightPos0.xyz, tmp1.xyz));
                tmp1.y = tmp1.x * tmp1.x;
                tmp1.y = dot(tmp1.xy, tmp3.xy);
                tmp1.y = tmp1.y - 0.5;
                tmp1.z = 1.0 - tmp2.x;
                tmp2.z = tmp1.z * tmp1.z;
                tmp2.z = tmp2.z * tmp2.z;
                tmp1.z = tmp1.z * tmp2.z;
                tmp1.z = tmp1.y * tmp1.z + 1.0;
                tmp2.z = 1.0 - abs(tmp0.w);
                tmp2.w = tmp2.z * tmp2.z;
                tmp2.w = tmp2.w * tmp2.w;
                tmp2.z = tmp2.z * tmp2.w;
                tmp1.y = tmp1.y * tmp2.z + 1.0;
                tmp1.y = tmp1.y * tmp1.z;
                tmp1.y = tmp2.x * tmp1.y;
                tmp1.z = tmp3.w * tmp3.w;
                tmp1.z = max(tmp1.z, 0.002);
                tmp2.w = 1.0 - tmp1.z;
                tmp3.x = abs(tmp0.w) * tmp2.w + tmp1.z;
                tmp2.w = tmp2.x * tmp2.w + tmp1.z;
                tmp0.w = abs(tmp0.w) * tmp2.w;
                tmp0.w = tmp2.x * tmp3.x + tmp0.w;
                tmp0.w = tmp0.w + 0.00001;
                tmp0.w = 0.5 / tmp0.w;
                tmp2.w = tmp1.z * tmp1.z;
                tmp3.x = tmp2.y * tmp2.w + -tmp2.y;
                tmp2.y = tmp3.x * tmp2.y + 1.0;
                tmp2.w = tmp2.w * 0.3183099;
                tmp2.y = tmp2.y * tmp2.y + 0.0000001;
                tmp2.y = tmp2.w / tmp2.y;
                tmp0.w = tmp0.w * tmp2.y;
                tmp0.w = tmp0.w * 3.141593;
                tmp0.w = max(tmp0.w, 0.0001);
                tmp0.w = sqrt(tmp0.w);
                tmp0.w = tmp2.x * tmp0.w;
                tmp1.z = tmp1.z * 0.28;
                tmp1.z = -tmp1.z * tmp3.w + 1.0;
                tmp2.x = dot(tmp0.xyz, tmp0.xyz);
                tmp2.x = tmp2.x != 0.0;
                tmp2.x = tmp2.x ? 1.0 : 0.0;
                tmp0.w = tmp0.w * tmp2.x;
                tmp1.w = tmp4.w - tmp1.w;
                tmp1.w = saturate(tmp1.w + 1.0);
                tmp2.xyw = tmp1.yyy * tmp6.xyz;
                tmp3.xyz = tmp6.xyz * tmp0.www;
                tmp0.w = 1.0 - tmp1.x;
                tmp1.x = tmp0.w * tmp0.w;
                tmp1.x = tmp1.x * tmp1.x;
                tmp0.w = tmp0.w * tmp1.x;
                tmp5.xyz = float3(1.0, 1.0, 1.0) - tmp0.xyz;
                tmp5.xyz = tmp5.xyz * tmp0.www + tmp0.xyz;
                tmp3.xyz = tmp3.xyz * tmp5.xyz;
                tmp2.xyw = tmp4.xyz * tmp2.xyw + tmp3.xyz;
                tmp1.xyz = tmp8.xyz * tmp1.zzz;
                tmp3.xyz = tmp1.www - tmp0.xyz;
                tmp0.xyz = tmp2.zzz * tmp3.xyz + tmp0.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.xyz + tmp2.xyw;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 74064
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float3 texcoord2 : TEXCOORD2;
				float3 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float4 color : COLOR0;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 unity_WorldToLight;
			float4 _MainTex0_ST;
			float4 _MainTex1_ST;
			float4 _MainTex2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float _BlendStrength;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
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
                o.texcoord.xy = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
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
                o.texcoord2.y = tmp3.x;
                o.texcoord2.x = tmp2.z;
                o.texcoord2.z = tmp1.y;
                o.texcoord3.x = tmp2.x;
                o.texcoord4.x = tmp2.y;
                o.texcoord3.z = tmp1.z;
                o.texcoord4.z = tmp1.x;
                o.texcoord3.y = tmp3.y;
                o.texcoord4.y = tmp3.z;
                o.texcoord5.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.color = v.color;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord6.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                o.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
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
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord5.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp0.xyz;
                tmp2.xyz = _WorldSpaceCameraPos - inp.texcoord5.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3 = tex2D(_Heights, inp.texcoord.xy);
                tmp4 = tex2D(_Heights, inp.texcoord.zw);
                tmp5 = tex2D(_Heights, inp.texcoord1.xy);
                tmp5.x = tmp3.x;
                tmp5.y = tmp4.y;
                tmp3.xyz = tmp5.xyz * inp.color.xyz;
                tmp3.xyz = log(tmp3.xyz);
                tmp3.xyz = tmp3.xyz * _BlendStrength.xxx;
                tmp3.xyz = exp(tmp3.xyz);
                tmp1.w = tmp3.y + tmp3.x;
                tmp1.w = tmp3.z + tmp1.w;
                tmp3.xyz = tmp3.xyz / tmp1.www;
                tmp4 = tex2D(_MainTex0, inp.texcoord.xy);
                tmp5 = tex2D(_MainTex1, inp.texcoord.zw);
                tmp5 = tmp3.yyyy * tmp5;
                tmp4 = tmp4 * tmp3.xxxx + tmp5;
                tmp5 = tex2D(_MainTex2, inp.texcoord1.xy);
                tmp4 = tmp5 * tmp3.zzzz + tmp4;
                tmp1.w = dot(tmp3.xyz, float3(_Smoothness0.x, _Smoothness1.x, _Smoothness2.x));
                tmp4.w = tmp1.w * tmp4.w;
                tmp1.w = dot(tmp3.xyz, float3(_BlendStrength.x, _Metallic0.x, _Metallic1.x));
                tmp5 = tex2D(_BumpMap0, inp.texcoord.xy);
                tmp6 = tex2D(_BumpMap1, inp.texcoord.zw);
                tmp6.xyz = tmp3.yyy * tmp6.xyw;
                tmp3.xyw = tmp5.xyw * tmp3.xxx + tmp6.xyz;
                tmp5 = tex2D(_BumpMap2, inp.texcoord1.xy);
                tmp3.yzw = tmp5.xyw * tmp3.zzz + tmp3.xyw;
                tmp3.x = tmp3.w * tmp3.y;
                tmp3.xy = tmp3.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp2.w = dot(tmp3.xy, tmp3.xy);
                tmp2.w = min(tmp2.w, 1.0);
                tmp2.w = 1.0 - tmp2.w;
                tmp3.z = sqrt(tmp2.w);
                tmp2.w = _ThermalVisionOn > 0.0;
                tmp5.xyz = tmp4.xyz * _Temperature2.zzz;
                tmp5.xyz = max(tmp5.xyz, _Temperature2.xxx);
                tmp5.xyz = min(tmp5.xyz, _Temperature2.yyy);
                tmp5.xyz = tmp5.xyz + _Temperature2.www;
                tmp3.w = tmp4.w * _Temperature2.z;
                tmp3.w = max(tmp3.w, _Temperature2.x);
                tmp5.w = min(tmp3.w, _Temperature2.y);
                tmp4 = tmp2.wwww ? tmp5 : tmp4;
                tmp5.xyz = inp.texcoord5.yyy * unity_WorldToLight._m01_m11_m21;
                tmp5.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord5.xxx + tmp5.xyz;
                tmp5.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord5.zzz + tmp5.xyz;
                tmp5.xyz = tmp5.xyz + unity_WorldToLight._m03_m13_m23;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp6.xyz = inp.texcoord5.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord5.xxx + tmp6.xyz;
                    tmp6.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord5.zzz + tmp6.xyz;
                    tmp6.xyz = tmp6.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp6.xyz = tmp2.www ? tmp6.xyz : inp.texcoord5.xyz;
                    tmp6.xyz = tmp6.xyz - unity_ProbeVolumeMin;
                    tmp6.yzw = tmp6.xyz * unity_ProbeVolumeSizeInv;
                    tmp2.w = tmp6.y * 0.25 + 0.75;
                    tmp3.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp6.x = max(tmp2.w, tmp3.w);
                    tmp6 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp6.xzw);
                } else {
                    tmp6 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp2.w = saturate(dot(tmp6, unity_OcclusionMaskSelector));
                tmp3.w = dot(tmp5.xyz, tmp5.xyz);
                tmp5 = tex2D(_LightTexture0, tmp3.ww);
                tmp2.w = tmp2.w * tmp5.x;
                tmp5.x = dot(inp.texcoord2.xyz, tmp3.xyz);
                tmp5.y = dot(inp.texcoord3.xyz, tmp3.xyz);
                tmp5.z = dot(inp.texcoord4.xyz, tmp3.xyz);
                tmp3.x = dot(tmp5.xyz, tmp5.xyz);
                tmp3.x = rsqrt(tmp3.x);
                tmp3.xyz = tmp3.xxx * tmp5.xyz;
                tmp5.xyz = tmp2.www * _LightColor0.xyz;
                tmp6.xyz = tmp4.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                tmp6.xyz = tmp1.www * tmp6.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp1.w = -tmp1.w * 0.7790837 + 0.7790837;
                tmp4.xyz = tmp1.www * tmp4.xyz;
                tmp1.w = 1.0 - tmp4.w;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = max(tmp0.w, 0.001);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(tmp3.xyz, tmp2.xyz);
                tmp2.x = saturate(dot(tmp3.xyz, tmp1.xyz));
                tmp2.y = saturate(dot(tmp3.xyz, tmp0.xyz));
                tmp0.x = saturate(dot(tmp1.xyz, tmp0.xyz));
                tmp0.y = tmp0.x * tmp0.x;
                tmp0.y = dot(tmp0.xy, tmp1.xy);
                tmp0.y = tmp0.y - 0.5;
                tmp0.z = 1.0 - tmp2.x;
                tmp1.x = tmp0.z * tmp0.z;
                tmp1.x = tmp1.x * tmp1.x;
                tmp0.z = tmp0.z * tmp1.x;
                tmp0.z = tmp0.y * tmp0.z + 1.0;
                tmp1.x = 1.0 - abs(tmp0.w);
                tmp1.y = tmp1.x * tmp1.x;
                tmp1.y = tmp1.y * tmp1.y;
                tmp1.x = tmp1.x * tmp1.y;
                tmp0.y = tmp0.y * tmp1.x + 1.0;
                tmp0.y = tmp0.y * tmp0.z;
                tmp0.z = tmp1.w * tmp1.w;
                tmp0.z = max(tmp0.z, 0.002);
                tmp1.x = 1.0 - tmp0.z;
                tmp1.y = abs(tmp0.w) * tmp1.x + tmp0.z;
                tmp1.x = tmp2.x * tmp1.x + tmp0.z;
                tmp0.w = abs(tmp0.w) * tmp1.x;
                tmp0.w = tmp2.x * tmp1.y + tmp0.w;
                tmp0.w = tmp0.w + 0.00001;
                tmp0.w = 0.5 / tmp0.w;
                tmp0.z = tmp0.z * tmp0.z;
                tmp1.x = tmp2.y * tmp0.z + -tmp2.y;
                tmp1.x = tmp1.x * tmp2.y + 1.0;
                tmp0.z = tmp0.z * 0.3183099;
                tmp1.x = tmp1.x * tmp1.x + 0.0000001;
                tmp0.z = tmp0.z / tmp1.x;
                tmp0.z = tmp0.z * tmp0.w;
                tmp0.z = tmp0.z * 3.141593;
                tmp0.z = max(tmp0.z, 0.0001);
                tmp0.z = sqrt(tmp0.z);
                tmp0.yz = tmp2.xx * tmp0.yz;
                tmp0.w = dot(tmp6.xyz, tmp6.xyz);
                tmp0.w = tmp0.w != 0.0;
                tmp0.w = tmp0.w ? 1.0 : 0.0;
                tmp0.z = tmp0.w * tmp0.z;
                tmp1.xyz = tmp0.yyy * tmp5.xyz;
                tmp0.yzw = tmp5.xyz * tmp0.zzz;
                tmp0.x = 1.0 - tmp0.x;
                tmp1.w = tmp0.x * tmp0.x;
                tmp1.w = tmp1.w * tmp1.w;
                tmp0.x = tmp0.x * tmp1.w;
                tmp2.xyz = float3(1.0, 1.0, 1.0) - tmp6.xyz;
                tmp2.xyz = tmp2.xyz * tmp0.xxx + tmp6.xyz;
                tmp0.xyz = tmp0.yzw * tmp2.xyz;
                o.sv_target.xyz = tmp4.xyz * tmp1.xyz + tmp0.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" }
			GpuProgramID 182075
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
				float4 color : COLOR0;
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
			float4 _MainTex0_ST;
			float4 _MainTex1_ST;
			float4 _MainTex2_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float _BlendStrength;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
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
                o.texcoord.xy = v.texcoord.xy * _MainTex0_ST.xy + _MainTex0_ST.zw;
                o.texcoord.zw = v.texcoord.xy * _MainTex1_ST.xy + _MainTex1_ST.zw;
                o.texcoord1.xy = v.texcoord.xy * _MainTex2_ST.xy + _MainTex2_ST.zw;
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
                o.texcoord3.x = tmp2.x;
                o.texcoord4.x = tmp2.y;
                o.texcoord3.z = tmp1.z;
                o.texcoord4.z = tmp1.x;
                o.texcoord3.w = tmp0.y;
                o.texcoord4.w = tmp0.z;
                o.texcoord3.y = tmp3.y;
                o.texcoord4.y = tmp3.z;
                o.color = v.color;
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
                tmp0 = tex2D(_MainTex0, inp.texcoord.xy);
                tmp1 = tex2D(_MainTex1, inp.texcoord.zw);
                tmp2 = tex2D(_Heights, inp.texcoord.xy);
                tmp3 = tex2D(_Heights, inp.texcoord.zw);
                tmp2.y = tmp3.y;
                tmp3 = tex2D(_Heights, inp.texcoord1.xy);
                tmp2.z = tmp3.z;
                tmp2.xyz = tmp2.xyz * inp.color.xyz;
                tmp2.xyz = log(tmp2.xyz);
                tmp2.xyz = tmp2.xyz * _BlendStrength.xxx;
                tmp2.xyz = exp(tmp2.xyz);
                tmp2.w = tmp2.y + tmp2.x;
                tmp2.w = tmp2.z + tmp2.w;
                tmp2.xyz = tmp2.xyz / tmp2.www;
                tmp1 = tmp1 * tmp2.yyyy;
                tmp0 = tmp0 * tmp2.xxxx + tmp1;
                tmp1 = tex2D(_MainTex2, inp.texcoord1.xy);
                tmp0 = tmp1 * tmp2.zzzz + tmp0;
                tmp1.x = dot(tmp2.xyz, float3(_Smoothness0.x, _Smoothness1.x, _Smoothness2.x));
                tmp0.w = tmp0.w * tmp1.x;
                tmp1.x = tmp0.w * _Temperature2.z;
                tmp1.x = max(tmp1.x, _Temperature2.x);
                tmp1.w = min(tmp1.x, _Temperature2.y);
                tmp3.xyz = tmp0.xyz * _Temperature2.zzz;
                tmp3.xyz = max(tmp3.xyz, _Temperature2.xxx);
                tmp3.xyz = min(tmp3.xyz, _Temperature2.yyy);
                tmp1.xyz = tmp3.xyz + _Temperature2.www;
                tmp2.w = _ThermalVisionOn > 0.0;
                tmp0 = tmp2.wwww ? tmp1 : tmp0;
                tmp1.x = dot(tmp2.xyz, float3(_BlendStrength.x, _Metallic0.x, _Metallic1.x));
                tmp1.y = -tmp1.x * 0.7790837 + 0.7790837;
                o.sv_target.xyz = tmp0.xyz * tmp1.yyy;
                o.sv_target.w = 1.0;
                tmp0.xyz = tmp0.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                o.sv_target1.w = tmp0.w;
                o.sv_target1.xyz = tmp1.xxx * tmp0.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp0 = tex2D(_BumpMap1, inp.texcoord.zw);
                tmp0.xyz = tmp2.yyy * tmp0.xyw;
                tmp1 = tex2D(_BumpMap0, inp.texcoord.xy);
                tmp0.xyz = tmp1.xyw * tmp2.xxx + tmp0.xyz;
                tmp1 = tex2D(_BumpMap2, inp.texcoord1.xy);
                tmp0.yzw = tmp1.xyw * tmp2.zzz + tmp0.xyz;
                tmp0.x = tmp0.w * tmp0.y;
                tmp0.xy = tmp0.xz * float2(2.0, 2.0) + float2(-1.0, -1.0);
                tmp0.w = dot(tmp0.xy, tmp0.xy);
                tmp0.w = min(tmp0.w, 1.0);
                tmp0.w = 1.0 - tmp0.w;
                tmp0.z = sqrt(tmp0.w);
                tmp1.x = dot(inp.texcoord2.xyz, tmp0.xyz);
                tmp1.y = dot(inp.texcoord3.xyz, tmp0.xyz);
                tmp1.z = dot(inp.texcoord4.xyz, tmp0.xyz);
                tmp0.x = dot(tmp1.xyz, tmp1.xyz);
                tmp0.x = rsqrt(tmp0.x);
                tmp0.xyz = tmp0.xxx * tmp1.xyz;
                o.sv_target2.xyz = tmp0.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
                o.sv_target2.w = 1.0;
                o.sv_target3 = float4(1.0, 1.0, 1.0, 1.0);
                return o;
			}
			ENDCG
		}
	}
	Fallback "Hidden/Internal-BlackError"
}