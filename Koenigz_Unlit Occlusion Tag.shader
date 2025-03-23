Shader "Koenigz/Unlit Occlusion Tag" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 0  //Cull Off is 0. Consider default properties.
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" }
		Pass {
			Cull [_Cull]   // Use the property for culling
			Fog {
				Mode Off
			}
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct v2f
			{
				float4 position : SV_POSITION;
			};

			struct fout
			{
				float4 sv_target : SV_Target;
			};

			// $Globals ConstantBuffers for Vertex Shader
			// $Globals ConstantBuffers for Fragment Shader
			// Custom ConstantBuffers for Vertex Shader
			// Custom ConstantBuffers for Fragment Shader
			//CBUFFER_START(Props) //Not required since _Color is a global shader property.
				float4 _Color;
			//CBUFFER_END
			// Texture params for Vertex Shader
			// Texture params for Fragment Shader
			
			// Keywords: 
			v2f vert(appdata_full v)
			{
                v2f o;
				// Use UNITY_MATRIX_MVP for built-in render pipeline
                o.position = UnityObjectToClipPos(v.vertex); 
                return o;
			}
			// Keywords: 
			fout frag(v2f inp)
			{
                fout o;
                float4 tmp0;
                float4 tmp1;
                float4 tmp2;
                tmp0.x = _Color.w >= 0.5;
                tmp0.yz = inp.position.zz + inp.position.xy;
                tmp0.zw = tmp0.yz * float2(0.618034, 0.618034);  // Golden ratio.  Used for a simple dither.
                tmp0.z = dot(tmp0.xy, tmp0.xy);
                tmp0.z = sqrt(tmp0.z);
                tmp0.z = tmp0.z * 12.0;
                tmp1.x = sin(tmp0.z);
                tmp2.x = cos(tmp0.z);
                tmp0.z = tmp1.x / tmp2.x;
                tmp0.y = tmp0.y * tmp0.z;
                tmp0.y = frac(tmp0.y);
                tmp0.y = tmp0.y < 0.75;
                tmp0.x = tmp0.y ? tmp0.x : 0.0;
                if (tmp0.x) {
                    discard;  // Discard the fragment if the dither condition is met
                }
                o.sv_target.xyz = _Color.xyz;
                o.sv_target.w = 1.0;
                return o;
			}
			ENDCG
		}
	}
	FallBack "Diffuse" // Fallback is VERY IMPORTANT for shadows and depth
}