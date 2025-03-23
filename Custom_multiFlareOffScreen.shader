Shader "Custom/multiFlareOffScreen" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Intensity ("Intensity", Float) = 2
		_FallofShift ("Fallof Shift", Float) = 3
		_FallofStrength ("Fallof Strength", Float) = 1
		_DepthOffset ("DepthOffset", Float) = 0.1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB
			ZTest Always
			ZWrite Off
			Fog {
				Mode Off
			}
			GpuProgramID 50128
			// No subprograms found
		}
	}
	Fallback "Hidden/Internal-BlackError"
}