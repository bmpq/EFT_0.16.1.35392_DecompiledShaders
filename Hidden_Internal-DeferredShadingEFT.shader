Shader "Hidden/Internal-DeferredShadingEFT" {
	Properties {
		_LightTexture0 ("", any) = "" {}
		_LightTextureB0 ("", 2D) = "" {}
		_ShadowMapTexture ("", any) = "" {}
		_SrcBlend ("", Float) = 1
		_DstBlend ("", Float) = 1
	}
	SubShader {
		Pass {
			Tags { "SHADOWSUPPORT" = "true" }
			Blend Zero Zero, Zero Zero
			ZWrite Off
			GpuProgramID 23844
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
			float _LightAsQuad;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightPos;
			float4 _LightColor;
			float _NightVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _LightTextureB0;
			sampler2D _CameraGBufferTexture0;
			sampler2D _CameraGBufferTexture1;
			sampler2D _CameraGBufferTexture2;
			
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
                tmp0 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                tmp1 = tmp0.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp1 = unity_MatrixVP._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp1 = unity_MatrixVP._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                tmp1 = unity_MatrixVP._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                o.position = tmp1;
                tmp1.y = tmp1.y * _ProjectionParams.x;
                tmp2.xzw = tmp1.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp1.zw;
                o.texcoord.xy = tmp2.zz + tmp2.xw;
                tmp1.xyz = tmp0.yyy * unity_MatrixV._m01_m11_m21;
                tmp1.xyz = unity_MatrixV._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_MatrixV._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                tmp0.xyz = unity_MatrixV._m03_m13_m23 * tmp0.www + tmp0.xyz;
                tmp1.xyz = tmp0.xyz * float3(-1.0, -1.0, 1.0);
                tmp0.xyz = -tmp0.xyz * float3(-1.0, -1.0, 1.0) + v.normal.xyz;
                o.texcoord1.xyz = _LightAsQuad.xxx * tmp0.xyz + tmp1.xyz;
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
                tmp0.x = _ProjectionParams.z / inp.texcoord1.z;
                tmp0.xyz = tmp0.xxx * inp.texcoord1.xyz;
                tmp1.xy = inp.texcoord.xy / inp.texcoord.ww;
                tmp2 = tex2D(_CameraDepthTexture, tmp1.xy);
                tmp0.w = _ZBufferParams.x * tmp2.x + _ZBufferParams.y;
                tmp0.w = 1.0 / tmp0.w;
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp2.xyz = tmp0.yyy * unity_CameraToWorld._m01_m11_m21;
                tmp0.xyw = unity_CameraToWorld._m00_m10_m20 * tmp0.xxx + tmp2.xyz;
                tmp0.xyz = unity_CameraToWorld._m02_m12_m22 * tmp0.zzz + tmp0.xyw;
                tmp0.xyz = tmp0.xyz + unity_CameraToWorld._m03_m13_m23;
                tmp2.xyz = tmp0.xyz - _WorldSpaceCameraPos;
                tmp0.xyz = tmp0.xyz - _LightPos.xyz;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp1.z = rsqrt(tmp0.w);
                tmp0.w = tmp0.w * _LightPos.w;
                tmp3 = tex2D(_LightTextureB0, tmp0.ww);
                tmp3.xyz = tmp3.xxx * _LightColor.xyz;
                tmp4.xyz = -tmp0.xyz * tmp1.zzz + -tmp2.xyz;
                tmp0.xyz = tmp0.xyz * tmp1.zzz;
                tmp0.w = dot(tmp4.xyz, tmp4.xyz);
                tmp0.w = max(tmp0.w, 0.001);
                tmp0.w = rsqrt(tmp0.w);
                tmp4.xyz = tmp0.www * tmp4.xyz;
                tmp5 = tex2D(_CameraGBufferTexture2, tmp1.xy);
                tmp5.xyz = tmp5.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
                tmp0.w = dot(tmp5.xyz, tmp5.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp5.xyz = tmp0.www * tmp5.xyz;
                tmp0.w = saturate(dot(tmp5.xyz, tmp4.xyz));
                tmp1.z = saturate(dot(-tmp0.xyz, tmp4.xyz));
                tmp0.x = saturate(dot(tmp5.xyz, -tmp0.xyz));
                tmp0.y = dot(tmp5.xyz, -tmp2.xyz);
                tmp2 = tex2D(_CameraGBufferTexture1, tmp1.xy);
                tmp4 = tex2D(_CameraGBufferTexture0, tmp1.xy);
                tmp1.xyw = max(tmp4.xyz, float3(0.0, 0.0, 0.0));
                tmp0.z = 1.0 - tmp2.w;
                tmp2.w = tmp0.z * tmp0.z;
                tmp2.w = max(tmp2.w, 0.002);
                tmp3.w = tmp2.w * tmp2.w;
                tmp4.x = tmp0.w * tmp3.w + -tmp0.w;
                tmp0.w = tmp4.x * tmp0.w + 1.0;
                tmp0.w = tmp0.w * tmp0.w + 0.0000001;
                tmp3.w = tmp3.w * 0.3183099;
                tmp0.w = tmp3.w / tmp0.w;
                tmp3.w = 1.0 - tmp2.w;
                tmp4.x = abs(tmp0.y) * tmp3.w + tmp2.w;
                tmp2.w = tmp0.x * tmp3.w + tmp2.w;
                tmp2.w = abs(tmp0.y) * tmp2.w;
                tmp0.y = 1.0 - abs(tmp0.y);
                tmp2.w = tmp0.x * tmp4.x + tmp2.w;
                tmp2.w = tmp2.w + 0.00001;
                tmp2.w = 0.5 / tmp2.w;
                tmp0.w = tmp0.w * tmp2.w;
                tmp0.w = tmp0.w * 3.141593;
                tmp0.w = max(tmp0.w, 0.0001);
                tmp0.w = sqrt(tmp0.w);
                tmp0.w = tmp0.x * tmp0.w;
                tmp2.w = dot(_LightColor.xyz, _LightColor.xyz);
                tmp4.x = sqrt(tmp2.w);
                tmp4.yz = float2(0.0, 0.0);
                tmp4.xyz = _LightColor.xyz - tmp4.xyz;
                tmp2.w = dot(tmp4.xyz, tmp4.xyz);
                tmp2.w = sqrt(tmp2.w);
                tmp2.w = tmp2.w < 0.0001;
                tmp4.xy = tmp2.ww ? float2(0.0, 0.4) : float2(1.0, 1.0);
                tmp5.xyz = tmp2.xyz * tmp4.xxx;
                tmp2.xyz = -tmp2.xyz * tmp4.xxx + float3(1.0, 1.0, 1.0);
                tmp1.xyw = min(tmp1.xyw, tmp4.yyy);
                tmp3.w = dot(tmp5.xyz, tmp5.xyz);
                tmp3.w = tmp3.w != 0.0;
                tmp3.w = tmp3.w ? 1.0 : 0.0;
                tmp0.w = tmp0.w * tmp3.w;
                tmp3.w = _NightVisionOn < 1.0;
                tmp2.w = tmp2.w ? tmp3.w : 0.0;
                tmp2.w = tmp2.w ? 0.0 : 1.0;
                tmp3.xyz = tmp2.www * tmp3.xyz;
                tmp4.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = 1.0 - tmp1.z;
                tmp2.w = tmp0.w * tmp0.w;
                tmp2.w = tmp2.w * tmp2.w;
                tmp0.w = tmp0.w * tmp2.w;
                tmp2.xyz = tmp2.xyz * tmp0.www + tmp5.xyz;
                tmp2.xyz = tmp2.xyz * tmp4.xyz;
                tmp0.w = tmp0.y * tmp0.y;
                tmp0.w = tmp0.w * tmp0.w;
                tmp0.y = tmp0.y * tmp0.w;
                tmp0.w = tmp1.z + tmp1.z;
                tmp0.w = tmp1.z * tmp0.w;
                tmp0.z = tmp0.w * tmp0.z + -0.5;
                tmp0.y = tmp0.z * tmp0.y + 1.0;
                tmp0.w = 1.0 - tmp0.x;
                tmp1.z = tmp0.w * tmp0.w;
                tmp1.z = tmp1.z * tmp1.z;
                tmp0.w = tmp0.w * tmp1.z;
                tmp0.z = tmp0.z * tmp0.w + 1.0;
                tmp0.y = tmp0.y * tmp0.z;
                tmp0.x = tmp0.x * tmp0.y;
                tmp0.xyz = tmp0.xxx * tmp3.xyz;
                tmp0.xyz = tmp1.xyw * tmp0.xyz + tmp2.xyz;
                tmp0.w = 1.0;
                o.sv_target = exp(-tmp0);
                return o;
			}
			ENDCG
		}
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				CompFront Equal
				PassFront Keep
				FailFront Keep
				ZFailFront Keep
				CompBack Equal
				PassBack Keep
				FailBack Keep
				ZFailBack Keep
			}
			GpuProgramID 97366
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _LightBuffer;
			
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
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                tmp0 = tex2D(_LightBuffer, inp.texcoord.xy);
                tmp0 = log(tmp0);
                o.sv_target = -tmp0;
                return o;
			}
			ENDCG
		}
	}
}