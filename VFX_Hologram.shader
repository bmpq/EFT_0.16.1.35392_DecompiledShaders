Shader "VFX/Hologram" {
	Properties {
		[Header(General)] _MainColor ("MainColor", Color) = (1,1,1,1)
		_Brightness ("Brightness", Range(0.1, 6)) = 3
		_Alpha ("Alpha", Range(0, 1)) = 1
		[Header(Fresnel)] _FresnelColor ("Color", Color) = (1,1,1,1)
		_FresnelPower ("Power", Range(0.1, 5)) = 3
		_FresnelOrient ("Orient", Range(0, 1)) = 0
		_FresnelWidth ("Width", Range(0.5, 2.3)) = 1
		[Header(Scan Line)] _ScanWidth ("Width", Vector) = (1,1,1,0)
		_ScanOffset ("Offset", Vector) = (-0.3,-0.6,0.15,0)
		_ScanEdge ("Edge", Vector) = (0.95,1,0,0)
		_ScanSpeed ("Speed", Vector) = (-1,-1,-1,0)
		_ScanTiling ("Tiling", Range(0.01, 300)) = 70
		_ScanIntensity ("Intensity", Range(0, 2)) = 0.65
	}
	SubShader {
		Pass {
			ColorMask 0
			Fog {
				Mode 0
			}
			GpuProgramID 77375
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 color : COLOR0;
				float4 position : SV_POSITION0;
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
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
