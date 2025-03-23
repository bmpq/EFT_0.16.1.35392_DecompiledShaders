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
				Mode 0
			}
			GpuProgramID 28642
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
			// $Globals ConstantBuffers for Fragment Shader
			float _InvSqRadius;
			float3 _LightPosition;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraGBufferTexture2;
			sampler2D _LightTextureB0;
			sampler2D _CameraGBufferTexture1;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
