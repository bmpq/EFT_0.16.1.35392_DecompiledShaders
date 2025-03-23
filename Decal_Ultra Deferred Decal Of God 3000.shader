Shader "Decal/Ultra Deferred Decal Of God 3000" {
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Specular Color", Color) = (1,1,1,0)
        [HDR] _EmissionColor ("Emission", Color) = (0,0,0,0)
        _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _NormalIntensity ("Normal Intensity", Range(0, 1)) = 0
        _Factor ("Z Offset Angle", Float) = 0
        _Units ("Z Offset Forward", Float) = 0
        _Temperature ("_Temperature", Vector) = (0.1,0.12,0.28,0)
    }
    SubShader {
        Tags { "QUEUE" = "Geometry+5" "RenderType" = "Transparent" }
        Pass {
            Name "DEFERRED"
            Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Geometry+5" "RenderType" = "Transparent" }
            Blend SrcAlpha OneMinusSrcAlpha, Zero One
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            struct v2f
            {
                float4 position : SV_POSITION0;
                float4 texcoord : TEXCOORD0;
                float3 texcoord1 : TEXCOORD1;
                float3 texcoord2 : TEXCOORD2;
                float3 texcoord3 : TEXCOORD3;
            };
            struct fout
            {
                float4 sv_target : SV_Target0;
                float4 sv_target1 : SV_Target1;
                float4 sv_target2 : SV_Target2;
                float4 sv_target3 : SV_Target3;
            };
            // $Globals ConstantBuffers for Vertex Shader
            float4 _MainTex_ST;
            float4 _BumpMap_ST;
            // $Globals ConstantBuffers for Fragment Shader
            float4 _Color;
            float4 _EmissionColor;
            float _NormalIntensity;
            float4 _Temperature;
            float _ThermalVisionOn; //This is unused

            sampler2D _BumpMap;
            sampler2D _MainTex;

            v2f vert(appdata_full v)
            {
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);
                o.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.texcoord.zw = TRANSFORM_TEX(v.texcoord, _BumpMap);

                TANGENT_SPACE_ROTATION;
                o.texcoord1 = rotation[0].xyz;
                o.texcoord2 = rotation[1].xyz;
                o.texcoord3 = rotation[2].xyz;

                return o;
            }

            fout frag(v2f inp)
            {
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;

                // Sample the main texture
                float4 mainTex = tex2D(_MainTex, inp.texcoord.xy);

                // Normal map processing
                tmp0 = tex2D(_BumpMap, inp.texcoord.zw);
                tmp0.xyz = UnpackNormal(tmp0); // Unpack the normal
				tmp0.xyz = normalize(tmp0.xyz);
                tmp0.xyz = tmp0.xyz * _NormalIntensity;

                //o.sv_target1 = float4(1,1,1,0);

                tmp2.x = dot(inp.texcoord1.xyz, tmp0.xyz);
                tmp2.y = dot(inp.texcoord2.xyz, tmp0.xyz);
                tmp2.z = dot(inp.texcoord3.xyz, tmp0.xyz);
                o.sv_target2.xyz = tmp2.xyz * 0.5 + 0.5;
                o.sv_target2.w = mainTex.w * _NormalIntensity;

                // Emission
                //tmp0 = min(tmp1, 0.999); //disable emission, it dont work??? in hdr 
                //tmp0 = tmp1 * _EmissionColor;
                o.sv_target3.xyz = float3(0,0,0);
                o.sv_target3.w = 0;

                return o;
            }
            ENDCG
        }
    }
}