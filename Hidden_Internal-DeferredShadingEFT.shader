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
			GpuProgramID 32417
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
			float4 _LightPos;
			float _NightVisionOn;
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			sampler2D _CameraGBufferTexture2;
			sampler2D _LightTextureB0;
			sampler2D _CameraGBufferTexture0;
			sampler2D _CameraGBufferTexture1;
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
