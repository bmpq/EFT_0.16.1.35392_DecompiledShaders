Shader "Custom/Matcap_Icon" {
	Properties {
		[Header(Base Properties)] [Space] _Color ("Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex ("Matcap", 2D) = "white" {}
		[Header(Attenuation Properties)] [Space] _AttenuationAmount ("Amount", Float) = 0.45
		_AttenuationRange ("Range", Float) = 0.3
		_AttenuationSoftness ("Softness", Float) = 0.35
		[Header(HSBC Properties)] [Space] _Hue ("Hue", Range(0, 1)) = 0
		_Saturation ("Saturation", Range(0, 1)) = 0.5
		_Brightness ("Brightness", Range(0, 1)) = 0.5
		_Contrast ("Contrast", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 899
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 position : SV_POSITION0;
				float3 texcoord : TEXCOORD0;
				float3 texcoord1 : TEXCOORD1;
				float4 texcoord4 : TEXCOORD4;
				float4 texcoord5 : TEXCOORD5;
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
			sampler2D _MainTex;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                tmp0 = v.vertex.yyyy * cb0[1];
                tmp0 = cb0[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb0[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb0[3];
                o.texcoord1.xyz = cb0[3].xyz * v.vertex.www + tmp0.xyz;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                tmp0.x = dot(v.normal.xyz, cb0[4].xyz);
                tmp0.y = dot(v.normal.xyz, cb0[5].xyz);
                tmp0.z = dot(v.normal.xyz, cb0[6].xyz);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                o.texcoord.xyz = tmp0.www * tmp0.xyz;
                o.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
                o.texcoord5 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
