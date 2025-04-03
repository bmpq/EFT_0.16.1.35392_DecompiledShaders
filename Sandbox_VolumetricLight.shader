Shader "Sandbox/VolumetricLight" {
	Properties {
		[HideInInspector] _MainTex ("Texture", 2D) = "white" {}
		[HideInInspector] _ZTest ("ZTest", Float) = 0
		[HideInInspector] _LightColor ("_LightColor", Color) = (1,1,1,1)
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" }
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			Cull Front
			GpuProgramID 36354
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 _WorldViewProj;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightPos;
			float4 _LightColor;
			float3 _CameraForward;
			float4 _VolumetricLight;
			float4 _MieG;
			int _SampleCount;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _DitherTexture;
			sampler2D _LightTextureB0;
			
			// Keywords: POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * _WorldViewProj._m01_m11_m21_m31;
                tmp0 = _WorldViewProj._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = _WorldViewProj._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = _WorldViewProj._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.position = tmp0;
                tmp0.y = tmp0.y * _ProjectionParams.x;
                tmp1.xzw = tmp0.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp0.zw;
                o.texcoord.xy = tmp1.zz + tmp1.xw;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                o.texcoord1.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
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
                tmp0.xy = inp.texcoord.xy / inp.texcoord.ww;
                tmp0 = tex2D(_CameraDepthTexture, tmp0.xy);
                tmp0.yzw = inp.texcoord1.xyz - _WorldSpaceCameraPos;
                tmp1.x = dot(tmp0.xyz, tmp0.xyz);
                tmp1.x = sqrt(tmp1.x);
                tmp0.yzw = tmp0.yzw / tmp1.xxx;
                tmp0.x = _ZBufferParams.z * tmp0.x + _ZBufferParams.w;
                tmp0.x = 1.0 / tmp0.x;
                tmp1.y = dot(_CameraForward, tmp0.xyz);
                tmp0.x = tmp0.x / tmp1.y;
                tmp0.x = min(tmp0.x, tmp1.x);
                tmp1.xy = floor(inp.position.xy);
                tmp1.xy = tmp1.xy * float2(0.125, 0.125);
                tmp1.zw = tmp1.xy >= -tmp1.xy;
                tmp1.xy = frac(abs(tmp1.xy));
                tmp1.xy = tmp1.zw ? tmp1.xy : -tmp1.xy;
                tmp1.xy = tmp1.xy + float2(0.0625, 0.0625);
                tmp1 = tex2D(_DitherTexture, tmp1.xy);
                tmp1.x = floor(_SampleCount);
                tmp0.x = tmp0.x / tmp1.x;
                tmp1.xyz = tmp0.xxx * tmp0.yzw;
                tmp1.xyz = tmp1.xyz * tmp1.www + _WorldSpaceCameraPos;
                tmp2.xyz = _WorldSpaceCameraPos - tmp1.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = sqrt(tmp1.w);
                tmp1.w = tmp1.w * _VolumetricLight.y;
                tmp1.w = tmp1.w * 0.5;
                tmp2.x = tmp0.x * _VolumetricLight.x;
                tmp2.yzw = tmp1.xyz;
                tmp3.xyz = float3(0.0, 0.0, 0.0);
                tmp3.w = tmp1.w;
                tmp4.x = 0.0;
                for (int i = tmp4.x; i < _SampleCount; i += 1) {
                    tmp4.yzw = tmp2.yzw - _LightPos.xyz;
                    tmp5.x = dot(tmp4.xyz, tmp4.xyz);
                    tmp5.y = tmp5.x * _LightPos.w;
                    tmp6 = tex2D(_LightTextureB0, tmp5.yy);
                    tmp3.w = _VolumetricLight.y * tmp0.x + tmp3.w;
                    tmp5.y = tmp2.x * tmp6.x;
                    tmp5.z = tmp3.w * -1.442695;
                    tmp5.z = exp(tmp5.z);
                    tmp5.y = tmp5.z * tmp5.y;
                    tmp5.x = rsqrt(tmp5.x);
                    tmp4.yzw = tmp4.yzw * tmp5.xxx;
                    tmp4.y = dot(tmp4.xyz, -tmp0.xyz);
                    tmp4.y = -_MieG.z * tmp4.y + _MieG.y;
                    tmp4.y = log(tmp4.y);
                    tmp4.y = tmp4.y * 1.5;
                    tmp4.y = exp(tmp4.y);
                    tmp4.y = _MieG.x / tmp4.y;
                    tmp4.y = tmp4.y * _MieG.w;
                    tmp3.xyz = tmp5.yyy * tmp4.yyy + tmp3.xyz;
                    tmp2.yzw = tmp0.yzw * tmp0.xxx + tmp2.yzw;
                }
                tmp0.xyz = tmp3.xyz * _LightColor.xyz;
                o.sv_target.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                o.sv_target.w = 0.0;
                return o;
			}
			ENDCG
		}
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			Cull Front
			GpuProgramID 106772
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 _WorldViewProj;
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
                tmp0 = v.vertex.yyyy * _WorldViewProj._m01_m11_m21_m31;
                tmp0 = _WorldViewProj._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = _WorldViewProj._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = _WorldViewProj._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.position = tmp0;
                tmp0.y = tmp0.y * _ProjectionParams.x;
                tmp1.xzw = tmp0.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp0.zw;
                o.texcoord.xy = tmp1.zz + tmp1.xw;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                o.texcoord1.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 141392
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 _WorldViewProj;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightPos;
			float4 _LightColor;
			float3 _CameraForward;
			float4 _VolumetricLight;
			float4 _MieG;
			int _SampleCount;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _DitherTexture;
			sampler2D _LightTextureB0;
			
			// Keywords: POINT
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * _WorldViewProj._m01_m11_m21_m31;
                tmp0 = _WorldViewProj._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = _WorldViewProj._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = _WorldViewProj._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.position = tmp0;
                tmp0.y = tmp0.y * _ProjectionParams.x;
                tmp1.xzw = tmp0.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp0.zw;
                o.texcoord.xy = tmp1.zz + tmp1.xw;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                o.texcoord1.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
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
                tmp0.xy = inp.texcoord.xy / inp.texcoord.ww;
                tmp0 = tex2D(_CameraDepthTexture, tmp0.xy);
                tmp0.yzw = inp.texcoord1.xyz - _WorldSpaceCameraPos;
                tmp1.x = dot(tmp0.xyz, tmp0.xyz);
                tmp1.x = sqrt(tmp1.x);
                tmp0.yzw = tmp0.yzw / tmp1.xxx;
                tmp1.xyz = _WorldSpaceCameraPos - _LightPos.xyz;
                tmp1.w = dot(tmp0.xyz, tmp1.xyz);
                tmp1.x = dot(tmp1.xyz, tmp1.xyz);
                tmp1.x = -_VolumetricLight.z * _VolumetricLight.z + tmp1.x;
                tmp1.x = tmp1.w * tmp1.w + -tmp1.x;
                tmp1.x = sqrt(tmp1.x);
                tmp1.y = -tmp1.x - tmp1.w;
                tmp1.x = tmp1.x - tmp1.w;
                tmp0.x = _ZBufferParams.z * tmp0.x + _ZBufferParams.w;
                tmp0.x = 1.0 / tmp0.x;
                tmp1.z = dot(_CameraForward, tmp0.xyz);
                tmp0.x = tmp0.x / tmp1.z;
                tmp0.x = min(tmp0.x, tmp1.x);
                tmp1.xzw = tmp0.yzw * tmp1.yyy + _WorldSpaceCameraPos;
                tmp0.x = tmp0.x - tmp1.y;
                tmp2.xy = floor(inp.position.xy);
                tmp2.xy = tmp2.xy * float2(0.125, 0.125);
                tmp2.zw = tmp2.xy >= -tmp2.xy;
                tmp2.xy = frac(abs(tmp2.xy));
                tmp2.xy = tmp2.zw ? tmp2.xy : -tmp2.xy;
                tmp2.xy = tmp2.xy + float2(0.0625, 0.0625);
                tmp2 = tex2D(_DitherTexture, tmp2.xy);
                tmp1.y = floor(_SampleCount);
                tmp0.x = tmp0.x / tmp1.y;
                tmp2.xyz = tmp0.xxx * tmp0.yzw;
                tmp1.xyz = tmp2.xyz * tmp2.www + tmp1.xzw;
                tmp2.xyz = _WorldSpaceCameraPos - tmp1.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = sqrt(tmp1.w);
                tmp1.w = tmp1.w * _VolumetricLight.y;
                tmp1.w = tmp1.w * 0.5;
                tmp2.x = tmp0.x * _VolumetricLight.x;
                tmp2.yzw = tmp1.xyz;
                tmp3.xyz = float3(0.0, 0.0, 0.0);
                tmp3.w = tmp1.w;
                tmp4.x = 0.0;
                for (int i = tmp4.x; i < _SampleCount; i += 1) {
                    tmp4.yzw = tmp2.yzw - _LightPos.xyz;
                    tmp5.x = dot(tmp4.xyz, tmp4.xyz);
                    tmp5.y = tmp5.x * _LightPos.w;
                    tmp6 = tex2D(_LightTextureB0, tmp5.yy);
                    tmp3.w = _VolumetricLight.y * tmp0.x + tmp3.w;
                    tmp5.y = tmp2.x * tmp6.x;
                    tmp5.z = tmp3.w * -1.442695;
                    tmp5.z = exp(tmp5.z);
                    tmp5.y = tmp5.z * tmp5.y;
                    tmp5.x = rsqrt(tmp5.x);
                    tmp4.yzw = tmp4.yzw * tmp5.xxx;
                    tmp4.y = dot(tmp4.xyz, -tmp0.xyz);
                    tmp4.y = -_MieG.z * tmp4.y + _MieG.y;
                    tmp4.y = log(tmp4.y);
                    tmp4.y = tmp4.y * 1.5;
                    tmp4.y = exp(tmp4.y);
                    tmp4.y = _MieG.x / tmp4.y;
                    tmp4.y = tmp4.y * _MieG.w;
                    tmp3.xyz = tmp5.yyy * tmp4.yyy + tmp3.xyz;
                    tmp2.yzw = tmp0.yzw * tmp0.xxx + tmp2.yzw;
                }
                tmp0.xyz = tmp3.xyz * _LightColor.xyz;
                o.sv_target.xyz = max(tmp0.xyz, float3(0.0, 0.0, 0.0));
                o.sv_target.w = 0.0;
                return o;
			}
			ENDCG
		}
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 208639
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float4 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4x4 _WorldViewProj;
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
                tmp0 = v.vertex.yyyy * _WorldViewProj._m01_m11_m21_m31;
                tmp0 = _WorldViewProj._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = _WorldViewProj._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp0 = _WorldViewProj._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                o.position = tmp0;
                tmp0.y = tmp0.y * _ProjectionParams.x;
                tmp1.xzw = tmp0.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp0.zw;
                o.texcoord.xy = tmp1.zz + tmp1.xw;
                tmp0.xyz = v.vertex.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp0.xyz = unity_ObjectToWorld._m00_m10_m20 * v.vertex.xxx + tmp0.xyz;
                tmp0.xyz = unity_ObjectToWorld._m02_m12_m22 * v.vertex.zzz + tmp0.xyz;
                o.texcoord1.xyz = unity_ObjectToWorld._m03_m13_m23 * v.vertex.www + tmp0.xyz;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                o.sv_target = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Blend One One
			ZWrite Off
			Cull Off
			GpuProgramID 280539
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _FrustumCorners[4];
			// $Globals ConstantBuffers for Fragment Shader
			float4 _VolumetricLight;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			
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
                o.texcoord.xy = v.texcoord.xy;
                tmp0.x = v.texcoord.y * 2.0 + v.texcoord.x;
                o.texcoord1.xyz = _FrustumCorners[tmp0.x].xyz;
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                tmp0 = tex2D(_CameraDepthTexture, inp.texcoord.xy);
                tmp0.x = _ZBufferParams.x * tmp0.x + _ZBufferParams.y;
                tmp0.x = 1.0 / tmp0.x;
                tmp0.x = tmp0.x > 0.999999;
                o.sv_target.w = tmp0.x ? _VolumetricLight.w : 0.0;
                o.sv_target.xyz = float3(0.0, 0.0, 0.0);
                return o;
			}
			ENDCG
		}
	}
}