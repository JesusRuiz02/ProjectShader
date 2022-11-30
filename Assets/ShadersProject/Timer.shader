Shader "Custom/Timer"
{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert 

            sampler2D _MainTex;
            sampler2D _BumpMap;
            float4 _Color;

            struct Input {
                float2 uv_MainTex;
                float2 uv_BumpMap;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = _Color;
            }
            ENDCG
    }
        FallBack "Diffuse"
}

