Shader "Unlit/new"
{
    Properties{
        _Range("Range", Range(0,1)) = 0
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _NormalTex("Normap map", 2D) = "bump" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Transparency("Transparency", Range(0,1)) = 0.0
        _ScrollXSpeed("X scroll speed", Range(-10, 10)) = 1
        _ScrollYSpeed("Y scroll speed", Range(-10, 10)) = 1

    }

        SubShader{
            Tags { "Queue" = "Transparent" }
            LOD 200
            Cull Off
            CGPROGRAM
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma surface surf Standard alpha vertex:vert

            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            sampler2D _MainTex;
            sampler2D _NormalTex;
            fixed _ScrollXSpeed;
            fixed _ScrollYSpeed;
            half _Range;

            struct Input {
                float2 uv_MainTex;
                float2 uv_NormalTex;
            };
            void vert(inout appdata_full v)
            {
                v.vertex.xyz += v.normal * _Range;
            }

            half _Glossiness;
            half _Metallic;
            float _Transparency;

            fixed4 _Color;

            void surf(Input IN, inout SurfaceOutputStandard o) {
                fixed offsetX = _ScrollXSpeed * _Time.x;
                fixed offsetY = _ScrollYSpeed * _Time.x;
                fixed2 offsetUV = fixed2(offsetX, offsetY);

                fixed2 normalUV = IN.uv_NormalTex + offsetUV;
                fixed2 mainUV = IN.uv_MainTex + offsetUV;
                

                // Albedo comes from a texture tinted by color
                fixed4 c = tex2D(_MainTex, mainUV) * _Color;
                o.Albedo = c.rgb;
                //o.Albedo = tex2D(_MainTex, IN.uv_MainTex);

                float4 normalPixel = tex2D(_NormalTex, normalUV);
                float3 n = UnpackNormal(normalPixel);
                o.Normal = n.xyz;

                o.Smoothness = _Glossiness;
                o.Alpha = _Transparency;

                

            }
            ENDCG
        }
            FallBack "Diffuse"
}