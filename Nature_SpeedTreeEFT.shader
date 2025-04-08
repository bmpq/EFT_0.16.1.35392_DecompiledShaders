// replaced with AlphaTest-Bumped from DefaultResourcesExtra

Shader "Nature/SpeedTreeEFT" {
    Properties {
        _Color ("Main Color", Vector) = (1,1,1,1)
        _HueVariation ("Hue Variation", Vector) = (1,0.5,0,0.1)
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
        _DetailTex ("Detail", 2D) = "black" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.333
        [MaterialEnum(Off,0,Front,1,Back,2)] _Cull ("Cull", Float) = 2
        [MaterialEnum(None,0,Fastest,1,Fast,2,Better,3,Best,4,Palm,5)] _WindQuality ("Wind Quality", Range(0, 5)) = 0
        _Temperature2 ("_Temperature2(min, max, factor)", Vector) = (0.04,0.17,0.3,0)
    }

SubShader {
    Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
    LOD 300

CGPROGRAM
#pragma surface surf Lambert alphatest:_Cutoff

sampler2D _MainTex;
sampler2D _BumpMap;
fixed4 _Color;

struct Input {
    float2 uv_MainTex;
    float2 uv_BumpMap;
};

void surf (Input IN, inout SurfaceOutput o) {
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = c.rgb;
    o.Alpha = c.a;
    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
}
ENDCG
}

FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}
