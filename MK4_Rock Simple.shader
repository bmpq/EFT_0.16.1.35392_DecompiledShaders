Shader "MK4/Rock Simple" {
	Properties {
		_Metallic ("Metallic", Range(0, 1)) = 0
		_Gloss ("Gloss", Range(0, 1)) = 0
		_Color ("Color", Vector) = (0.5019608,0.5019608,0.5019608,1)
		_Aldebo ("Aldebo", 2D) = "white" {}
		_Normalmap ("Normalmap", 2D) = "bump" {}
		_AOPower ("AO Power", Range(0, 3)) = 1
		_AO ("AO", 2D) = "white" {}
		_MaskColor ("Mask Color", Vector) = (1,1,1,1)
		_MaskPower ("Mask Power", Range(0, 1.5)) = 1
		_Maskscale ("Mask scale", Range(0, 20)) = 2
		_MaskRGBA ("Mask RGBA", 2D) = "white" {}
		_DetailDiffInt ("Detail Diff Int", Range(0, 1)) = 0
		_Detailscale ("Detail scale", Range(0, 20)) = 2
		[MaterialToggle] _DetailBlendDodge ("Detail Blend Dodge", Float) = 0.3882353
		_Detail ("Detail", 2D) = "white" {}
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _			struct v2f
			{
				float4 position : SV_POSITION0;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				float3 texcoord4 : TEXCOORD4;
				float3 texcoord5 : TEXCOORD5;
				float3 texcoord6 : TEXCOORD6;
				float4 texcoord10 : TEXCOORD10;
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
			sampler2D _Normalmap;
			sampler2D _AO;
			sampler2D _Detail;
			sampler2D _Aldebo;
			sampler2D _MaskRGBA;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                tmp0 = v.vertex.yyyy * cb0[1];
                tmp0 = cb0[0] * v.vertex.xxxx + tmp0;
                tmp0 = cb0[2] * v.vertex.zzzz + tmp0;
                tmp1 = tmp0 + cb0[3];
                o.texcoord3 = cb0[3] * v.vertex.wwww + tmp0;
                tmp0 = tmp1.yyyy * cb1[18];
                tmp0 = cb1[17] * tmp1.xxxx + tmp0;
                tmp0 = cb1[19] * tmp1.zzzz + tmp0;
                o.position = cb1[20] * tmp1.wwww + tmp0;
                o.texcoord.xy = v.texcoord.xy;
                o.texcoord1.xy = v.texcoord1.xy;
                o.texcoord2.xy = v.texcoord2.xy;
                tmp0.x = dot(v.normal.xyz, cb0[4].xyz);
                tmp0.y = dot(v.normal.xyz, cb0[5].xyz);
                tmp0.z = dot(v.normal.xyz, cb0[6].xyz);
                tmp0.w = dot(tmp0.xyz, tmp0.xyz);
                tmp0.w = rsqrt(tmp0.w);
                tmp0.xyz = tmp0.www * tmp0.xyz;
                o.texcoord4.xyz = tmp0.xyz;
                tmp1.xyz = v.tangent.yyy * cb0[1].xyz;
                tmp1.xyz = cb0[0].xyz * v.tangent.xxx + tmp1.xyz;
                tmp1.xyz = cb0[2].xyz * v.tangent.zzz + tmp1.xyz;
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
                o.texcoord10 = float4(0.0, 0.0, 0.0, 0.0);
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
