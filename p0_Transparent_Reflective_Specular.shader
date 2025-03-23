Shader "p0/Transparent/Reflective/Specular" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_SpecTex ("Specular (R)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
	}
	SubShader {
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Overlay" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Overlay" "RenderType" = "Overlay" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			Stencil {
				Ref 6
				WriteMask 6
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 33018
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
			float4 _ReflectColor;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecTex;
			samplerCUBE _Cube;
			
			// Keywords: DIRECTIONAL
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
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
                tmp1.xyz = _WorldSpaceCameraPos - tmp0.xyz;
                o.texcoord3.xyz = tmp0.xyz;
                tmp0.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp0.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp0.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(-tmp1.xyz, tmp0.xyz);
                tmp0.w = tmp0.w + tmp0.w;
                o.texcoord1.xyz = tmp0.xyz * -tmp0.www + -tmp1.xyz;
                o.texcoord2.xyz = tmp0.xyz;
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
                tmp0.xyz = _WorldSpaceCameraPos - inp.texcoord3.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2 = tmp1 * _Color;
                tmp3 = tex2D(_SpecTex, inp.texcoord.xy);
                tmp1.xyz = tmp2.xyz * tmp3.xxx;
                tmp4 = texCUBE(_Cube, inp.texcoord1.xyz);
                tmp3.yzw = tmp1.www * tmp4.xyz;
                tmp3.yzw = tmp3.yzw * _ReflectColor.xyz;
                tmp2.xyz = tmp3.xxx * tmp3.yzw;
                tmp1.w = _ThermalVisionOn > 0.0;
                tmp2 = tmp1.wwww ? float4(0.0, 0.0, 0.0, 1.0) : tmp2;
                tmp3.y = unity_ProbeVolumeParams.x == 1.0;
                if (tmp3.y) {
                    tmp3.y = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord3.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord3.xxx + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord3.zzz + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp3.yzw = tmp3.yyy ? tmp4.xyz : inp.texcoord3.xyz;
                    tmp3.yzw = tmp3.yzw - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp3.yzw * unity_ProbeVolumeSizeInv;
                    tmp3.y = tmp4.y * 0.25 + 0.75;
                    tmp3.z = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp3.z, tmp3.y);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp3.y = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp3.yzw = tmp3.yyy * _LightColor0.xyz;
                tmp0.xyz = tmp0.xyz * tmp0.www + _WorldSpaceLightPos0.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(inp.texcoord2.xyz, _WorldSpaceLightPos0.xyz);
                tmp0.x = dot(inp.texcoord2.xyz, tmp0.xyz);
                tmp0.xw = max(tmp0.xw, float2(0.0, 0.0));
                tmp0.y = tmp3.x * 128.0;
                tmp0.x = log(tmp0.x);
                tmp0.x = tmp0.x * tmp0.y;
                tmp0.x = exp(tmp0.x);
                tmp0.x = tmp3.x * tmp0.x;
                tmp1.xyz = tmp1.xyz * tmp3.yzw;
                tmp1.xyz = tmp1.www ? float3(0.0, 0.0, 0.0) : tmp1.xyz;
                tmp3.xyz = tmp3.yzw * _SpecColor.xyz;
                tmp0.xyz = tmp0.xxx * tmp3.xyz;
                tmp0.xyz = tmp1.xyz * tmp0.www + tmp0.xyz;
                o.sv_target.xyz = tmp2.xyz + tmp0.xyz;
                o.sv_target.w = tmp2.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Overlay" "RenderType" = "Overlay" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			Stencil {
				Ref 6
				WriteMask 6
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 96469
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
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _SpecTex;
			sampler2D _LightTexture0;
			
			// Keywords: POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                o.position = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp1.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp1.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp1.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp1.w = dot(tmp1.xyz, tmp1.xyz);
                tmp1.w = rsqrt(tmp1.w);
                o.texcoord1.xyz = tmp1.www * tmp1.xyz;
                o.texcoord2.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord3.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
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
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp1.xyz = _WorldSpaceCameraPos - inp.texcoord2.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2 = tmp2 * _Color;
                tmp3 = tex2D(_SpecTex, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * tmp3.xxx;
                tmp1.w = _ThermalVisionOn > 0.0;
                tmp2 = tmp1.wwww ? float4(0.0, 0.0, 0.0, 1.0) : tmp2;
                tmp3.yzw = inp.texcoord2.yyy * unity_WorldToLight._m01_m11_m21;
                tmp3.yzw = unity_WorldToLight._m00_m10_m20 * inp.texcoord2.xxx + tmp3.yzw;
                tmp3.yzw = unity_WorldToLight._m02_m12_m22 * inp.texcoord2.zzz + tmp3.yzw;
                tmp3.yzw = tmp3.yzw + unity_WorldToLight._m03_m13_m23;
                tmp1.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp1.w) {
                    tmp1.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp4.xyz = inp.texcoord2.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.xxx + tmp4.xyz;
                    tmp4.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord2.zzz + tmp4.xyz;
                    tmp4.xyz = tmp4.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp4.xyz = tmp1.www ? tmp4.xyz : inp.texcoord2.xyz;
                    tmp4.xyz = tmp4.xyz - unity_ProbeVolumeMin;
                    tmp4.yzw = tmp4.xyz * unity_ProbeVolumeSizeInv;
                    tmp1.w = tmp4.y * 0.25 + 0.75;
                    tmp4.y = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp4.x = max(tmp1.w, tmp4.y);
                    tmp4 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp4.xzw);
                } else {
                    tmp4 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp1.w = saturate(dot(tmp4, unity_OcclusionMaskSelector));
                tmp3.y = dot(tmp3.xyz, tmp3.xyz);
                tmp4 = tex2D(_LightTexture0, tmp3.yy);
                tmp1.w = tmp1.w * tmp4.x;
                tmp3.yzw = tmp1.www * _LightColor0.xyz;
                tmp1.xyz = tmp1.xyz * tmp0.www + tmp0.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                tmp0.x = dot(inp.texcoord1.xyz, tmp0.xyz);
                tmp0.y = dot(inp.texcoord1.xyz, tmp1.xyz);
                tmp0.xy = max(tmp0.xy, float2(0.0, 0.0));
                tmp0.z = tmp3.x * 128.0;
                tmp0.y = log(tmp0.y);
                tmp0.y = tmp0.y * tmp0.z;
                tmp0.y = exp(tmp0.y);
                tmp0.y = tmp3.x * tmp0.y;
                tmp1.xyz = tmp2.xyz * tmp3.yzw;
                tmp2.xyz = tmp3.yzw * _SpecColor.xyz;
                tmp0.yzw = tmp0.yyy * tmp2.xyz;
                o.sv_target.xyz = tmp1.xyz * tmp0.xxx + tmp0.yzw;
                o.sv_target.w = tmp2.w;
                return o;
			}
			ENDCG
		}
	}
}