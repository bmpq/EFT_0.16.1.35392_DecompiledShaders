Shader "MK4/Rock" {
	Properties {
		_Metallic ("Metallic", Range(0, 1)) = 0
		_Gloss ("Gloss", Range(0, 1)) = 0
		_Color ("Color", Vector) = (0.5019608,0.5019608,0.5019608,1)
		_Aldebo ("Aldebo", 2D) = "white" {}
		_NormalmapInt ("Normalmap Int", Range(0, 2)) = 1
		_Normalmap ("Normalmap", 2D) = "bump" {}
		_AOPower ("AO Power", Range(0, 3)) = 1
		_AO ("AO", 2D) = "white" {}
		_MaskColor ("Mask Color", Vector) = (1,1,1,1)
		_MaskPower ("Mask Power", Range(0, 1.5)) = 1.5
		_MaskBumpInt ("Mask Bump Int", Range(0, 2)) = 1
		_Maskscale ("Mask scale", Range(0, 20)) = 2
		[MaterialToggle] _SmoothBlend ("Smooth Blend", Float) = 0
		_MaskRGBA ("Mask RGBA", 2D) = "white" {}
		_MaskBump ("Mask Bump", 2D) = "bump" {}
		_DetailDiffInt ("Detail Diff Int", Range(0, 1)) = 0
		_DetailBumpInt ("Detail Bump Int", Range(0, 2)) = 1
		_Detailscale ("Detail scale", Range(0, 20)) = 2
		[MaterialToggle] _DetailBlendDodge ("Detail Blend Dodge", Float) = 0.3882353
		_Detail ("Detail", 2D) = "white" {}
		_DetailBump ("Detail Bump", 2D) "bump" {}
		_Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.1,0.38,0.33,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "DEFERRED"
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 3171
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord7 : TEXCOORD7;
			};
			struct fout
			{
				float4 sv_target : SV_Target0;
				float4 sv_target1 : SV_Target1;
				float4 sv_target2 : SV_Target2;
				float4 sv_target3 : SV_Target3;
			};
			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			float4 _Color;
			float _Metallic;
			float _Gloss;
			float4 _Aldebo_ST;
			float4 _MaskRGBA_ST;
			float4 _Normalmap_ST;
			float4 _MaskBump_ST;
			float4 _Detail_ST;
			float4 _DetailBump_ST;
			float _Detailscale;
			float4 _AO_ST;
			float4 _MaskColor;
			float _DetailBumpInt;
			float _DetailDiffInt;
			float _Maskscale;
			float _MaskPower;
			float _MaskBumpInt;
			float _AOPower;
			float _DetailBlendDodge;
			float _SmoothBlend;
			float _NormalmapInt;
			float4 _Temperature2;
			float _ThermalVisionOn;
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
                tmp0 = v.vertex.yyyy * unity_ObjectToWorld._m01_m11_m21_m31;
                tmp0 = unity_ObjectToWorld._m00_m10_m20_m30 * v.vertex.xxxx + tmp0;
                tmp0 = unity_ObjectToWorld._m02_m12_m22_m32 * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + unity_ObjectToWorld._m03_m13_m23_m33;
                o.texcoord3 = unity_ObjectToWorld._m03_m13_m23_m33 * v.vertex.wwww + tmp0;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                o.texcoord.xy = v.texcoord.xy;
                o.texcoord1.xy = v.texcoord1.xy;
                o.texcoord2.xy = v.texcoord2.xy;
                tmp0.x = dot(v.normal.xyz, unity_WorldToObject._m00_m10_m20);
                tmp0.y = dot(v.normal.xyz, unity_WorldToObject._m01_m11_m21);
                tmp0.z = dot(v.normal.xyz, unity_WorldToObject._m02_m12_m22);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                o.texcoord4.xyz = tmp0.xyz;
                tmp1.xyz = v.tangent.yyy * unity_ObjectToWorld._m01_m11_m21;
                tmp1.xyz = unity_ObjectToWorld._m00_m10_m20 * v.tangent.xxx + tmp1.xyz;
                tmp1.xyz = unity_ObjectToWorld._m02_m12_m22 * v.tangent.zzz + tmp1.xyz;
                tmp0.w = dot(tmp1.xyz, tmp1.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp1.xyz = tmp0.www * tmp1.xyz;
                o.texcoord5.xyz = tmp1.xyz;
                tmp2.xyz = tmp0.zxy * tmp1.yzx;
                tmp0.xyz = tmp0.yzx * tmp1.zxy + -tmp2.xyz;
                tmp0.xyz = tmp0.xyz * v.tangent.www;
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                o.texcoord6.xyz = tmp0.www * tmp0.xyz;
                o.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
