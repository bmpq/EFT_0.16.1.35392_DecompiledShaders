// Upgrade NOTE: replaced 'glstate_matrix_projection' with 'UNITY_MATRIX_P'

Shader "CustomLights/Light" {
	Properties {
		[HDR] _Color ("_Color", Color) = (1,1,1,1)
		_LightPosition ("_LightPosition", Vector) = (0,0,0,0)
		_InvSqRadius ("_InvSqRadius", Float) = 0.5
	}
	SubShader {
		Pass {
			Blend Zero Zero, Zero Zero
			ZTest Less
			ZWrite Off
			Fog {
				Mode Off
			}
			GpuProgramID 20872
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
			float _FullScreen;
			float3 _CubeHelperScale;
			float3 _CubeHelperShift;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _Color;
			float3 _LightPosition;
			float _InvSqRadius;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraDepthTexture;
			sampler2D _LightTextureB0;
			sampler2D _CameraGBufferTexture1;
			sampler2D _CameraGBufferTexture2;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                float4 tmp3;
                tmp0 = unity_ObjectToWorld._m12_m12_m12_m12 * unity_MatrixV._m01_m11_m21_m31;
                tmp0 = unity_MatrixV._m00_m10_m20_m30 * unity_ObjectToWorld._m02_m02_m02_m02 + tmp0;
                tmp0 = unity_MatrixV._m02_m12_m22_m32 * unity_ObjectToWorld._m22_m22_m22_m22 + tmp0;
                tmp0 = unity_MatrixV._m03_m13_m23_m33 * unity_ObjectToWorld._m32_m32_m32_m32 + tmp0;
                tmp1 = unity_ObjectToWorld._m10_m10_m10_m10 * unity_MatrixV._m01_m11_m21_m31;
                tmp1 = unity_MatrixV._m00_m10_m20_m30 * unity_ObjectToWorld._m00_m00_m00_m00 + tmp1;
                tmp1 = unity_MatrixV._m02_m12_m22_m32 * unity_ObjectToWorld._m20_m20_m20_m20 + tmp1;
                tmp1 = unity_MatrixV._m03_m13_m23_m33 * unity_ObjectToWorld._m30_m30_m30_m30 + tmp1;
                tmp2 = unity_ObjectToWorld._m11_m11_m11_m11 * unity_MatrixV._m01_m11_m21_m31;
                tmp2 = unity_MatrixV._m00_m10_m20_m30 * unity_ObjectToWorld._m01_m01_m01_m01 + tmp2;
                tmp2 = unity_MatrixV._m02_m12_m22_m32 * unity_ObjectToWorld._m21_m21_m21_m21 + tmp2;
                tmp2 = unity_MatrixV._m03_m13_m23_m33 * unity_ObjectToWorld._m31_m31_m31_m31 + tmp2;
                tmp3.xyz = v.vertex.xyz * _CubeHelperScale + _CubeHelperShift;
                tmp3.xyz = max(tmp3.xyz, float3(-0.5, -0.5, -0.5));
                tmp3.xyz = min(tmp3.xyz, float3(0.5, 0.5, 0.5));
                tmp2 = tmp2 * tmp3.yyyy;
                tmp1 = tmp1 * tmp3.xxxx + tmp2;
                tmp0 = tmp0 * tmp3.zzzz + tmp1;
                tmp1 = unity_ObjectToWorld._m13_m13_m13_m13 * unity_MatrixV._m01_m11_m21_m31;
                tmp1 = unity_MatrixV._m00_m10_m20_m30 * unity_ObjectToWorld._m03_m03_m03_m03 + tmp1;
                tmp1 = unity_MatrixV._m02_m12_m22_m32 * unity_ObjectToWorld._m23_m23_m23_m23 + tmp1;
                tmp1 = unity_MatrixV._m03_m13_m23_m33 * unity_ObjectToWorld._m33_m33_m33_m33 + tmp1;
                tmp0 = tmp1 * v.vertex.wwww + tmp0;
                tmp3.w = 0.0;
                tmp1.xyz = tmp3.xyw - tmp0.xyz;
                tmp1.xyz = _FullScreen.xxx * tmp1.xyz + tmp0.xyz;
                tmp2 = tmp1.yyyy * UNITY_MATRIX_P._m01_m11_m21_m31;
                tmp2 = UNITY_MATRIX_P._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp0.x = _ProjectionParams.y * 1.0001;
                tmp1.w = min(-tmp0.x, tmp1.z);
                o.texcoord1.xyz = tmp1.xyw * float3(-1.0, -1.0, 1.0);
                tmp1 = UNITY_MATRIX_P._m02_m12_m22_m32 * tmp1.wwww + tmp2;
                tmp0 = UNITY_MATRIX_P._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                o.position = tmp0;
                tmp0.y = tmp0.y * _ProjectionParams.x;
                tmp1.xzw = tmp0.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord.zw = tmp0.zw;
                o.texcoord.xy = tmp1.zz + tmp1.xw;
                return o;
			}
			// Keywords: POINT SPECULAR
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
                tmp0.xyz = tmp0.xyz - _LightPosition;
                tmp0.w = dot(tmp2.xyz, tmp2.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp2.xyz = tmp0.www * tmp2.xyz;
                tmp3 = tex2D(_CameraGBufferTexture2, tmp1.xy);
                tmp1 = tex2D(_CameraGBufferTexture1, tmp1.xy);
                tmp3.xyz = tmp3.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
                tmp0.w = dot(tmp3.xyz, tmp3.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp3.xyz = tmp0.www * tmp3.xyz;
                tmp0.w = dot(tmp3.xyz, -tmp2.xyz);
                tmp0.w = max(tmp0.w, 0.0);
                tmp4 = float4(1.0, 1.0, 1.0, 1.0) - tmp1.wxyz;
                tmp1.w = tmp4.x * tmp4.x;
                tmp2.w = -tmp1.w * 0.5 + 1.0;
                tmp5.xy = tmp1.ww * float2(0.5, 0.3183099);
                tmp0.w = tmp0.w * tmp2.w + tmp5.x;
                tmp3.w = dot(tmp0.xyz, tmp0.xyz);
                tmp4.x = rsqrt(tmp3.w);
                tmp3.w = tmp3.w * _InvSqRadius;
                tmp6 = tex2D(_LightTextureB0, tmp3.ww);
                tmp6.xyz = tmp6.xxx * _Color.xyz;
                tmp7.xyz = tmp0.xyz * tmp4.xxx;
                tmp0.xyz = -tmp0.xyz * tmp4.xxx + -tmp2.xyz;
                tmp2.x = dot(tmp3.xyz, -tmp7.xyz);
                tmp2.x = max(tmp2.x, 0.0);
                tmp2.y = tmp2.x * tmp2.w + tmp5.x;
                tmp0.w = tmp2.y * tmp0.w + 0.00001;
                tmp0.w = 1.0 / tmp0.w;
                tmp2.y = dot(tmp0.xyz, tmp0.xyz);
                tmp2.y = rsqrt(tmp2.y);
                tmp0.xyz = tmp0.xyz * tmp2.yyy;
                tmp2.y = dot(tmp3.xyz, tmp0.xyz);
                tmp0.x = dot(-tmp7.xyz, tmp0.xyz);
                tmp0.x = max(tmp0.x, 0.0);
                tmp0.x = 1.0 - tmp0.x;
                tmp0.y = max(tmp2.y, 0.0);
                tmp0.z = tmp0.y * tmp1.w + -tmp0.y;
                tmp0.y = tmp0.z * tmp0.y + 1.0;
                tmp0.y = tmp0.y * tmp0.y + 0.0000001;
                tmp0.y = tmp5.y / tmp0.y;
                tmp0.y = tmp0.y * tmp0.w;
                tmp0.y = tmp2.x * tmp0.y;
                tmp0.y = tmp0.y * 0.6168503;
                tmp0.y = max(tmp0.y, 0.0);
                tmp0.yzw = tmp6.xyz * tmp0.yyy;
                tmp1.w = tmp0.x * tmp0.x;
                tmp1.w = tmp1.w * tmp1.w;
                tmp0.x = tmp0.x * tmp1.w;
                tmp1.xyz = tmp4.yzw * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = tmp0.yzw * tmp1.xyz;
                tmp0.w = 1.0;
                o.sv_target = exp(-tmp0);
                return o;
			}
			ENDCG
		}
	}
}