Shader "Global Fog/Transparent Reflective Specular" {
	Properties {
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
		_Color ("Main Color", Color) = (1,1,1,1)
		_Smoothness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0.5
		_AlphaOffset ("Alpha Offset", Range(-1, 1)) = 0
		_DirtStrength ("Dirt Strength", Range(0, 64)) = 3
		_GlobalReflectionStrength ("_GlobalReflectionStrength", Float) = 0.2
	}
	SubShader {
		LOD 300
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			ZWrite Off
			GpuProgramID 27628
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
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
				float4 texcoord6 : TEXCOORD6;
				float3 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
			};
			// $Globals ConstantBuffers for Vertex Shader
			float4 _MainTex_ST;
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float _ReflectionBottomShade;
			float4 _Color;
			float _Smoothness;
			float _DirtStrength;
			float _AlphaOffset;
			float _Metallic;
			float _GlobalReflectionStrength;
			float4 _EFT_Ambient;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _StencilShadow;
			samplerCUBE _MyGlobalReflectionProbe;
			sampler2D _SunCascadedShadowMap;
			
			// Keywords: DIRECTIONAL GAMMA LDR
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
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                tmp2 = tmp1.yyyy * unity_MatrixVP._m01_m11_m21_m31;
                tmp2 = unity_MatrixVP._m00_m10_m20_m30 * tmp1.xxxx + tmp2;
                tmp2 = unity_MatrixVP._m02_m12_m22_m32 * tmp1.zzzz + tmp2;
                tmp1 = unity_MatrixVP._m03_m13_m23_m33 * tmp1.wwww + tmp2;
                o.position = tmp1;
                o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                tmp2.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp2.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp2.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp2.w = dot(tmp2.xyz, tmp2.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp2.xyz = tmp2.www * tmp2.xyz;
                o.texcoord1.xyz = tmp2.xyz;
                o.texcoord2.xyz = tmp0.xyz;
                tmp1.y = tmp1.y * _ProjectionParams.x;
                tmp3.xzw = tmp1.xwy * float3(0.5, 0.5, 0.5);
                o.texcoord3.zw = tmp1.zw;
                o.texcoord3.xy = tmp3.zz + tmp3.xw;
                o.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord5 = tmp0;
                tmp1 = tmp0.yyyy * unity_MatrixV._m01_m11_m21_m31;
                tmp1 = unity_MatrixV._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp1 = unity_MatrixV._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                o.texcoord6 = unity_MatrixV._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                tmp0.x = tmp2.y * tmp2.y;
                tmp0.x = tmp2.x * tmp2.x + -tmp0.x;
                tmp1 = tmp2.yzzx * tmp2.xyzz;
                tmp2.x = dot(unity_SHBr, tmp1);
                tmp2.y = dot(unity_SHBg, tmp1);
                tmp2.z = dot(unity_SHBb, tmp1);
                o.texcoord7.xyz = unity_SHC.xyz * tmp0.xxx + tmp2.xyz;
                return o;
			}
			// Keywords: DIRECTIONAL GAMMA LDR
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
                float4 tmp13;
                float4 tmp14;
                tmp0.xyz = _WorldSpaceCameraPos - inp.texcoord2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp0.xyz;
                tmp2 = tex2D(_MainTex, inp.texcoord.xy);
                tmp2.xyz = tmp2.xyz * _Color.xyz;
                tmp1.w = log(tmp2.w);
                tmp1.w = tmp1.w * _DirtStrength;
                tmp1.w = exp(tmp1.w);
                tmp3.w = saturate(tmp1.w + _AlphaOffset);
                tmp1.w = tmp2.w * _Metallic;
                tmp4.x = dot(inp.texcoord1.xyz, inp.texcoord1.xyz);
                tmp4.x = rsqrt(tmp4.x);
                tmp4.xyz = tmp4.xxx * inp.texcoord1.xyz;
                tmp5.xyz = inp.texcoord5.xyz - _WorldSpaceCameraPos;
                tmp4.w = dot(tmp5.xyz, tmp5.xyz);
                tmp4.w = rsqrt(tmp4.w);
                tmp5.xyz = tmp4.www * tmp5.xyz;
                tmp4.w = max(tmp1.w, tmp1.w);
                tmp4.w = max(tmp1.w, tmp4.w);
                tmp4.w = 1.0 - tmp4.w;
                tmp5.w = dot(tmp5.xyz, tmp4.xyz);
                tmp5.w = tmp5.w + tmp5.w;
                tmp6.xyz = tmp4.xyz * -tmp5.www + tmp5.xyz;
                tmp5.w = 1.0 - _Smoothness;
                tmp6.w = -tmp5.w * 0.7 + 1.7;
                tmp6.w = tmp5.w * tmp6.w;
                tmp6.w = tmp6.w * 6.0;
                tmp7 = texCUBElod(_MyGlobalReflectionProbe, float4(tmp6.xyz, tmp6.w));
                tmp6.x = saturate(tmp6.y + _ReflectionBottomShade);
                tmp6.xyz = tmp6.xxx * tmp7.xyz;
                tmp5.x = dot(tmp4.xyz, -tmp5.xyz);
                tmp5.y = tmp5.w * tmp5.w;
                tmp5.y = max(tmp5.y, 0.002);
                tmp5.z = tmp5.y * 0.28;
                tmp5.z = -tmp5.z * tmp5.w + 1.0;
                tmp4.w = 1.0 - tmp4.w;
                tmp4.w = saturate(tmp4.w + _Smoothness);
                tmp6.xyz = tmp6.xyz * tmp5.zzz;
                tmp5.x = 1.0 - abs(tmp5.x);
                tmp7.x = tmp5.x * tmp5.x;
                tmp7.x = tmp7.x * tmp7.x;
                tmp5.x = tmp5.x * tmp7.x;
                tmp2.w = -_Metallic * tmp2.w + tmp4.w;
                tmp2.w = tmp5.x * tmp2.w + tmp1.w;
                tmp6.xyz = tmp2.www * tmp6.xyz;
                tmp6.xyz = tmp6.xyz * _GlobalReflectionStrength.xxx;
                tmp7.xyz = _Color.xyz * _EFT_Ambient.xyz;
                tmp6.xyz = tmp6.xyz * _GlobalReflectionStrength.xxx + tmp7.xyz;
                tmp7.xy = inp.texcoord3.xy / inp.texcoord3.ww;
                tmp7 = tex2D(_StencilShadow, tmp7.xy);
                tmp2.w = tmp7.y * tmp7.w;
                tmp2.w = saturate(tmp2.w * 1.5);
                tmp2.w = 1.0 - tmp2.w;
                //tmp7.xyz = inp.texcoord5.xyz - unity_ShadowSplitSpheres.xyz;
                //tmp8.xyz = inp.texcoord5.xyz - cb3[1].xyz;
                //tmp9.xyz = inp.texcoord5.xyz - cb3[2].xyz;
                //tmp10.xyz = inp.texcoord5.xyz - cb3[3].xyz;
                //tmp7.x = dot(tmp7.xyz, tmp7.xyz);
                //tmp7.y = dot(tmp8.xyz, tmp8.xyz);
                //tmp7.z = dot(tmp9.xyz, tmp9.xyz);
                //tmp7.w = dot(tmp10.xyz, tmp10.xyz);
                //tmp7 = tmp7 < unity_ShadowSplitSqRadii;
                //tmp8 = tmp7 ? 1.0 : 0.0;
                //tmp7.xyz = tmp7.xyz ? float3(-1.0, -1.0, -1.0) : float3(-0.0, -0.0, -0.0);
                //tmp7.xyz = tmp7.xyz + tmp8.yzw;
                //tmp8.yzw = max(tmp7.xyz, float3(0.0, 0.0, 0.0));
                //tmp7.xyz = inp.texcoord5.yyy * unity_WorldToShadow._m01_m11_m21;
                //tmp7.xyz = unity_WorldToShadow._m00_m10_m20 * inp.texcoord5.xxx + tmp7.xyz;
                //tmp7.xyz = unity_WorldToShadow._m02_m12_m22 * inp.texcoord5.zzz + tmp7.xyz;
                //tmp7.xyz = unity_WorldToShadow._m03_m13_m23 * inp.texcoord5.www + tmp7.xyz;
                //tmp9.xyz = inp.texcoord5.yyy * cb3[13].xyz;
                //tmp9.xyz = cb3[12].xyz * inp.texcoord5.xxx + tmp9.xyz;
                //tmp9.xyz = cb3[14].xyz * inp.texcoord5.zzz + tmp9.xyz;
                //tmp9.xyz = cb3[15].xyz * inp.texcoord5.www + tmp9.xyz;
                //tmp10.xyz = inp.texcoord5.yyy * cb3[17].xyz;
                //tmp10.xyz = cb3[16].xyz * inp.texcoord5.xxx + tmp10.xyz;
                //tmp10.xyz = cb3[18].xyz * inp.texcoord5.zzz + tmp10.xyz;
                //tmp10.xyz = cb3[19].xyz * inp.texcoord5.www + tmp10.xyz;
                //tmp11.xyz = inp.texcoord5.yyy * cb3[21].xyz;
                //tmp11.xyz = cb3[20].xyz * inp.texcoord5.xxx + tmp11.xyz;
                //tmp11.xyz = cb3[22].xyz * inp.texcoord5.zzz + tmp11.xyz;
                //tmp11.xyz = cb3[23].xyz * inp.texcoord5.www + tmp11.xyz;
                //tmp9.xyz = tmp8.yyy * tmp9.xyz;
                //tmp7.xyz = tmp7.xyz * tmp8.xxx + tmp9.xyz;
                //tmp7.xyz = tmp10.xyz * tmp8.zzz + tmp7.xyz;
                //tmp7.xyz = tmp11.xyz * tmp8.www + tmp7.xyz;
                //tmp4.w = dot(tmp8, float4(1.0, 1.0, 1.0, 1.0));
                //tmp4.w = tmp7.z - tmp4.w;
                //tmp4.w = tmp4.w + 1.0;
                //tmp4.w = tex2D(_SunCascadedShadowMap, tmp7.xy);
                //tmp5.x = 1.0 - _LightShadowData.x;
                //tmp4.w = tmp4.w * tmp5.x + _LightShadowData.x;
                //tmp4.w = max(tmp4.w, 0.3);
                //tmp3.xyz = tmp2.www * tmp6.xyz;
                //tmp2.w = _ThermalVisionOn > 0.0;
                //tmp2.xyz = tmp2.www ? float3(0.0, 0.0, 0.0) : tmp2.xyz;
                //tmp3 = tmp2.wwww ? float4(0.0, 0.0, 0.0, 1.0) : tmp3;
                //tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                //if (tmp2.w) {
                //    tmp5.x = unity_ProbeVolumeParams.y == 1.0;
                //    tmp6.xyz = inp.texcoord2.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                //    tmp6.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.xxx + tmp6.xyz;
                //    tmp6.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord2.zzz + tmp6.xyz;
                //    tmp6.xyz = tmp6.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                //    tmp6.xyz = tmp5.xxx ? tmp6.xyz : inp.texcoord2.xyz;
                //    tmp6.xyz = tmp6.xyz - unity_ProbeVolumeMin;
                //    tmp7.yzw = tmp6.xyz * unity_ProbeVolumeSizeInv;
                //    tmp5.x = tmp7.y * 0.25 + 0.75;
                //    tmp6.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                //    tmp7.x = max(tmp5.x, tmp6.x);
                //    tmp7 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp7.xzw);
                //} else {
                //    tmp7 = float4(1.0, 1.0, 1.0, 1.0);
                //}
                //tmp5.x = saturate(dot(tmp7, unity_OcclusionMaskSelector));
                //tmp6.x = dot(-tmp1.xyz, inp.texcoord1.xyz);
                //tmp6.x = tmp6.x + tmp6.x;
                //tmp6.xyz = inp.texcoord1.xyz * -tmp6.xxx + -tmp1.xyz;
                //tmp7.xyz = tmp5.xxx * _LightColor0.xyz;
                //if (tmp2.w) {
                //    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                //    tmp8.xyz = inp.texcoord2.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                //    tmp8.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.xxx + tmp8.xyz;
                //    tmp8.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord2.zzz + tmp8.xyz;
                //    tmp8.xyz = tmp8.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                //    tmp8.xyz = tmp2.www ? tmp8.xyz : inp.texcoord2.xyz;
                //    tmp8.xyz = tmp8.xyz - unity_ProbeVolumeMin;
                //    tmp8.yzw = tmp8.xyz * unity_ProbeVolumeSizeInv;
                //    tmp2.w = tmp8.y * 0.25;
                //    tmp5.x = unity_ProbeVolumeParams.z * 0.5;
                //    tmp7.w = -unity_ProbeVolumeParams.z * 0.5 + 0.25;
                //    tmp2.w = max(tmp2.w, tmp5.x);
                //    tmp8.x = min(tmp7.w, tmp2.w);
                //    tmp9 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp8.xzw);
                //    tmp10.xyz = tmp8.xzw + float3(0.25, 0.0, 0.0);
                //    tmp10 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp10.xyz);
                //    tmp8.xyz = tmp8.xzw + float3(0.5, 0.0, 0.0);
                //    tmp8 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp8.xyz);
                //    tmp11.xyz = inp.texcoord1.xyz;
                //    tmp11.w = 1.0;
                //    tmp9.x = dot(tmp9, tmp11);
                //    tmp9.y = dot(tmp10, tmp11);
                //    tmp9.z = dot(tmp8, tmp11);
                //} else {
                //    tmp8.xyz = inp.texcoord1.xyz;
                //    tmp8.w = 1.0;
                //    tmp9.x = dot(unity_SHAr, tmp8);
                //    tmp9.y = dot(unity_SHAg, tmp8);
                //    tmp9.z = dot(unity_SHAb, tmp8);
                //}
                //tmp8.xyz = tmp9.xyz + inp.texcoord7.xyz;
                //tmp8.xyz = max(tmp8.xyz, float3(0.0, 0.0, 0.0));
                //tmp8.xyz = log(tmp8.xyz);
                //tmp8.xyz = tmp8.xyz * float3(0.4166667, 0.4166667, 0.4166667);
                //tmp8.xyz = exp(tmp8.xyz);
                //tmp8.xyz = tmp8.xyz * float3(1.055, 1.055, 1.055) + float3(-0.055, -0.055, -0.055);
                //tmp8.xyz = max(tmp8.xyz, float3(0.0, 0.0, 0.0));
                //tmp2.w = unity_SpecCube0_ProbePosition.w > 0.0;
                //if (tmp2.w) {
                //    tmp2.w = dot(tmp6.xyz, tmp6.xyz);
                //    tmp2.w = rsqrt(tmp2.w);
                //    tmp9.xyz = tmp2.www * tmp6.xyz;
                //    tmp10.xyz = unity_SpecCube0_BoxMax.xyz - inp.texcoord2.xyz;
                //    tmp10.xyz = tmp10.xyz / tmp9.xyz;
                //    tmp11.xyz = unity_SpecCube0_BoxMin.xyz - inp.texcoord2.xyz;
                //    tmp11.xyz = tmp11.xyz / tmp9.xyz;
                //    tmp12.xyz = tmp9.xyz > float3(0.0, 0.0, 0.0);
                //    tmp10.xyz = tmp12.xyz ? tmp10.xyz : tmp11.xyz;
                //    tmp2.w = min(tmp10.y, tmp10.x);
                //    tmp2.w = min(tmp10.z, tmp2.w);
                //    tmp10.xyz = inp.texcoord2.xyz - unity_SpecCube0_ProbePosition.xyz;
                //    tmp9.xyz = tmp9.xyz * tmp2.www + tmp10.xyz;
                //} else {
                //    tmp9.xyz = tmp6.xyz;
                //}
                //tmp9 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp9.xyz, tmp6.w));
                //tmp2.w = tmp9.w - 1.0;
                //tmp2.w = unity_SpecCube0_HDR.w * tmp2.w + 1.0;
                //tmp2.w = tmp2.w * unity_SpecCube0_HDR.x;
                //tmp10.xyz = tmp9.xyz * tmp2.www;
                //tmp5.x = unity_SpecCube0_BoxMin.w < 0.99999;
                //if (tmp5.x) {
                //    tmp5.x = unity_SpecCube1_ProbePosition.w > 0.0;
                //    if (tmp5.x) {
                //        tmp5.x = dot(tmp6.xyz, tmp6.xyz);
                //        tmp5.x = rsqrt(tmp5.x);
                //        tmp11.xyz = tmp5.xxx * tmp6.xyz;
                //        tmp12.xyz = unity_SpecCube1_BoxMax.xyz - inp.texcoord2.xyz;
                //        tmp12.xyz = tmp12.xyz / tmp11.xyz;
                //        tmp13.xyz = unity_SpecCube1_BoxMin.xyz - inp.texcoord2.xyz;
                //        tmp13.xyz = tmp13.xyz / tmp11.xyz;
                //        tmp14.xyz = tmp11.xyz > float3(0.0, 0.0, 0.0);
                //        tmp12.xyz = tmp14.xyz ? tmp12.xyz : tmp13.xyz;
                //        tmp5.x = min(tmp12.y, tmp12.x);
                //        tmp5.x = min(tmp12.z, tmp5.x);
                //        tmp12.xyz = inp.texcoord2.xyz - unity_SpecCube1_ProbePosition.xyz;
                //        tmp6.xyz = tmp11.xyz * tmp5.xxx + tmp12.xyz;
                //    }
                //    tmp6 = UNITY_SAMPLE_TEXCUBE_SAMPLER(unity_SpecCube0, unity_SpecCube0, float4(tmp6.xyz, tmp6.w));
                //    tmp5.x = tmp6.w - 1.0;
                //    tmp5.x = unity_SpecCube1_HDR.w * tmp5.x + 1.0;
                //    tmp5.x = tmp5.x * unity_SpecCube1_HDR.x;
                //    tmp6.xyz = tmp6.xyz * tmp5.xxx;
                //    tmp9.xyz = tmp2.www * tmp9.xyz + -tmp6.xyz;
                //    tmp10.xyz = unity_SpecCube0_BoxMin.www * tmp9.xyz + tmp6.xyz;
                //}
                //tmp6.xyz = tmp4.www * tmp10.xyz;
                //tmp7.xyz = tmp4.www * tmp7.xyz;
                //tmp9.xyz = tmp2.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                //tmp9.xyz = tmp1.www * tmp9.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                //tmp1.w = -tmp1.w * 0.7790837 + 0.7790837;
                //tmp2.xyz = tmp1.www * tmp2.xyz;
                //tmp0.xyz = tmp0.xyz * tmp0.www + _WorldSpaceLightPos0.xyz;
                //tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                //tmp0.w = max(tmp0.w, 0.001);
                //tmp0.w = rsqrt(tmp0.w);
                //tmp0.xyz = tmp0.www * tmp0.xyz;
                //tmp0.w = dot(tmp4.xyz, tmp1.xyz);
                //tmp1.x = saturate(dot(tmp4.xyz, _WorldSpaceLightPos0.xyz));
                //tmp1.y = saturate(dot(tmp4.xyz, tmp0.xyz));
                //tmp0.x = saturate(dot(_WorldSpaceLightPos0.xyz, tmp0.xyz));
                //tmp0.y = tmp0.x * tmp0.x;
                //tmp0.y = dot(tmp0.xy, tmp5.xy);
                //tmp0.y = tmp0.y - 0.5;
                //tmp0.z = 1.0 - tmp1.x;
                //tmp1.z = tmp0.z * tmp0.z;
                //tmp1.z = tmp1.z * tmp1.z;
                //tmp0.z = tmp0.z * tmp1.z;
                //tmp0.z = tmp0.y * tmp0.z + 1.0;
                //tmp1.z = 1.0 - abs(tmp0.w);
                //tmp2.w = tmp1.z * tmp1.z;
                //tmp2.w = tmp2.w * tmp2.w;
                //tmp1.z = tmp1.z * tmp2.w;
                //tmp0.y = tmp0.y * tmp1.z + 1.0;
                //tmp0.y = tmp0.y * tmp0.z;
                //tmp0.z = 1.0 - tmp5.y;
                //tmp2.w = abs(tmp0.w) * tmp0.z + tmp5.y;
                //tmp0.z = tmp1.x * tmp0.z + tmp5.y;
                //tmp0.z = tmp0.z * abs(tmp0.w);
                //tmp0.z = tmp1.x * tmp2.w + tmp0.z;
                //tmp0.z = tmp0.z + 0.00001;
                //tmp0.z = 0.5 / tmp0.z;
                //tmp0.w = tmp5.y * tmp5.y;
                //tmp2.w = tmp1.y * tmp0.w + -tmp1.y;
                //tmp1.y = tmp2.w * tmp1.y + 1.0;
                //tmp0.w = tmp0.w * 0.3183099;
                //tmp1.y = tmp1.y * tmp1.y + 0.0000001;
                //tmp0.w = tmp0.w / tmp1.y;
                //tmp0.z = tmp0.w * tmp0.z;
                //tmp0.z = tmp0.z * 3.141593;
                //tmp0.z = max(tmp0.z, 0.0001);
                //tmp0.z = sqrt(tmp0.z);
                //tmp0.yz = tmp1.xx * tmp0.yz;
                //tmp0.w = dot(tmp9.xyz, tmp9.xyz);
                //tmp0.w = tmp0.w != 0.0;
                //tmp0.w = tmp0.w ? 1.0 : 0.0;
                //tmp0.z = tmp0.w * tmp0.z;
                //tmp0.w = 1.0 - tmp1.w;
                //tmp0.w = saturate(tmp0.w + _Smoothness);
                //tmp1.xyw = tmp0.yyy * tmp7.xyz;
                //tmp1.xyw = tmp8.xyz * tmp4.www + tmp1.xyw;
                //tmp4.xyz = tmp7.xyz * tmp0.zzz;
                //tmp0.x = 1.0 - tmp0.x;
                //tmp0.y = tmp0.x * tmp0.x;
                //tmp0.y = tmp0.y * tmp0.y;
                //tmp0.x = tmp0.x * tmp0.y;
                //tmp5.xyw = float3(1.0, 1.0, 1.0) - tmp9.xyz;
                //tmp0.xyz = tmp5.xyw * tmp0.xxx + tmp9.xyz;
                //tmp0.xyz = tmp0.xyz * tmp4.xyz;
                //tmp0.xyz = tmp2.xyz * tmp1.xyw + tmp0.xyz;
                //tmp1.xyw = tmp5.zzz * tmp6.xyz;
                //tmp2.xyz = tmp0.www - tmp9.xyz;
                //tmp2.xyz = tmp1.zzz * tmp2.xyz + tmp9.xyz;
                //tmp0.xyz = tmp1.xyw * tmp2.xyz + tmp0.xyz;
                //o.sv_target.xyz = tmp3.xyz + tmp0.xyz;
                o.sv_target.w = tmp3.w;
                return o;
			}
			ENDCG
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB
			ZWrite Off
			GpuProgramID 68095
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
				float4 texcoord3 : TEXCOORD3;
				float4 texcoord4 : TEXCOORD4;
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
			// $Globals ConstantBuffers for Fragment Shader
			float4 _LightColor0;
			float4 _Color;
			float _Smoothness;
			float _DirtStrength;
			float _AlphaOffset;
			float _Metallic;
			float _ThermalVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _MainTex;
			sampler2D _LightTexture0;
			
			// Keywords: GAMMA LDR POINT
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
                tmp0 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
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
                o.texcoord2.xyz = tmp0.xyz;
                o.texcoord3 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord4 = tmp0;
                tmp1 = tmp0.yyyy * unity_MatrixV._m01_m11_m21_m31;
                tmp1 = unity_MatrixV._m00_m10_m20_m30 * tmp0.xxxx + tmp1;
                tmp1 = unity_MatrixV._m02_m12_m22_m32 * tmp0.zzzz + tmp1;
                o.texcoord5 = unity_MatrixV._m03_m13_m23_m33 * tmp0.wwww + tmp1;
                tmp1.xyz = tmp0.yyy * unity_WorldToLight._m01_m11_m21;
                tmp1.xyz = unity_WorldToLight._m00_m10_m20 * tmp0.xxx + tmp1.xyz;
                tmp0.xyz = unity_WorldToLight._m02_m12_m22 * tmp0.zzz + tmp1.xyz;
                o.texcoord6.xyz = unity_WorldToLight._m03_m13_m23 * tmp0.www + tmp0.xyz;
                return o;
			}
			// Keywords: GAMMA LDR POINT
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
                tmp0.xyz = _WorldSpaceLightPos0.xyz - inp.texcoord2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp0.xyz;
                tmp2.xyz = _WorldSpaceCameraPos - inp.texcoord2.xyz;
                tmp1.w = dot(tmp2.xyz, tmp2.xyz);
                tmp1.w = rsqrt(tmp1.w);
                tmp2.xyz = tmp1.www * tmp2.xyz;
                tmp3 = tex2D(_MainTex, inp.texcoord.xy);
                tmp4.xyz = tmp3.xyz * _Color.xyz;
                tmp1.w = log(tmp3.w);
                tmp1.w = tmp1.w * _DirtStrength;
                tmp1.w = exp(tmp1.w);
                tmp4.w = saturate(tmp1.w + _AlphaOffset);
                tmp1.w = tmp3.w * _Metallic;
                tmp2.w = _ThermalVisionOn > 0.0;
                tmp3 = tmp2.wwww ? float4(0.0, 0.0, 0.0, 1.0) : tmp4;
                tmp4.xyz = inp.texcoord2.yyy * unity_WorldToLight._m01_m11_m21;
                tmp4.xyz = unity_WorldToLight._m00_m10_m20 * inp.texcoord2.xxx + tmp4.xyz;
                tmp4.xyz = unity_WorldToLight._m02_m12_m22 * inp.texcoord2.zzz + tmp4.xyz;
                tmp4.xyz = tmp4.xyz + unity_WorldToLight._m03_m13_m23;
                tmp2.w = unity_ProbeVolumeParams.x == 1.0;
                if (tmp2.w) {
                    tmp2.w = unity_ProbeVolumeParams.y == 1.0;
                    tmp5.xyz = inp.texcoord2.yyy * unity_ProbeVolumeWorldToObject._m01_m11_m21;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m00_m10_m20 * inp.texcoord2.xxx + tmp5.xyz;
                    tmp5.xyz = unity_ProbeVolumeWorldToObject._m02_m12_m22 * inp.texcoord2.zzz + tmp5.xyz;
                    tmp5.xyz = tmp5.xyz + unity_ProbeVolumeWorldToObject._m03_m13_m23;
                    tmp5.xyz = tmp2.www ? tmp5.xyz : inp.texcoord2.xyz;
                    tmp5.xyz = tmp5.xyz - unity_ProbeVolumeMin;
                    tmp5.yzw = tmp5.xyz * unity_ProbeVolumeSizeInv;
                    tmp2.w = tmp5.y * 0.25 + 0.75;
                    tmp4.w = unity_ProbeVolumeParams.z * 0.5 + 0.75;
                    tmp5.x = max(tmp2.w, tmp4.w);
                    tmp5 = UNITY_SAMPLE_TEX3D_SAMPLER(unity_ProbeVolumeSH, unity_ProbeVolumeSH, tmp5.xzw);
                } else {
                    tmp5 = float4(1.0, 1.0, 1.0, 1.0);
                }
                tmp2.w = saturate(dot(tmp5, unity_OcclusionMaskSelector));
                tmp4.x = dot(tmp4.xyz, tmp4.xyz);
                tmp4 = tex2D(_LightTexture0, tmp4.xx);
                tmp2.w = tmp2.w * tmp4.x;
                tmp4.xyz = tmp2.www * _LightColor0.xyz;
                tmp2.w = dot(inp.texcoord1.xyz, inp.texcoord1.xyz);
                tmp2.w = rsqrt(tmp2.w);
                tmp5.xyz = tmp2.www * inp.texcoord1.xyz;
                tmp6.xyz = tmp3.xyz - float3(0.2209163, 0.2209163, 0.2209163);
                tmp6.xyz = tmp1.www * tmp6.xyz + float3(0.2209163, 0.2209163, 0.2209163);
                tmp1.w = -tmp1.w * 0.7790837 + 0.7790837;
                tmp3.xyz = tmp1.www * tmp3.xyz;
                tmp1.w = 1.0 - _Smoothness;
                tmp0.xyz = tmp0.xyz * tmp0.www + tmp2.xyz;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = max(tmp0.w, 0.001);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                tmp0.w = dot(tmp5.xyz, tmp2.xyz);
                tmp2.x = saturate(dot(tmp5.xyz, tmp1.xyz));
                tmp2.y = saturate(dot(tmp5.xyz, tmp0.xyz));
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
                tmp1.xyz = tmp0.yyy * tmp4.xyz;
                tmp0.yzw = tmp4.xyz * tmp0.zzz;
                tmp0.x = 1.0 - tmp0.x;
                tmp1.w = tmp0.x * tmp0.x;
                tmp1.w = tmp1.w * tmp1.w;
                tmp0.x = tmp0.x * tmp1.w;
                tmp2.xyz = float3(1.0, 1.0, 1.0) - tmp6.xyz;
                tmp2.xyz = tmp2.xyz * tmp0.xxx + tmp6.xyz;
                tmp0.xyz = tmp0.yzw * tmp2.xyz;
                o.sv_target.xyz = tmp3.xyz * tmp1.xyz + tmp0.xyz;
                o.sv_target.w = tmp3.w;
                return o;
			}
			ENDCG
		}
	}
	Fallback "Reflective/VertexLit"
}