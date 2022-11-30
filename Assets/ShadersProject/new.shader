Shader "Custom/new"
{
    Properties{
        _Range("Range", Range(0,1)) = 0
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _ScrollXSpeed("X scroll speed", Range(-10, 10)) = 1
        _ScrollYSpeed("Y scroll speed", Range(-10, 10)) = 1
        _Cutoff("Alpha cutoff", Range(0,1)) = 0.5
    }

        SubShader{
            Tags { "Queue" = "Transparent" }
            LOD 200
            Cull Off
            CGPROGRAM
            
            #pragma surface surf Unlit alphatest:_Cutoff
            #pragma target 3.0

            sampler2D _MainTex;
            fixed _ScrollXSpeed;
            fixed _ScrollYSpeed;
            half _Range;

            struct Input {
                float2 uv_MainTex;
            };
            void vert(inout appdata_full v)
            {
                v.vertex.xyz += v.normal * _Range; //mueve el vertex con el range
            }

            float _Transparency;
            fixed4 _Color;

            half4 LightingUnlit(SurfaceOutput s, half3 lightDir, half atten)
            {
                return half4(s.Albedo, s.Alpha);
            }

            void surf(Input IN, inout SurfaceOutput o) {

                fixed offsetX = _ScrollXSpeed * _Time.x; //offset en x se agrego en una velocidad y se multiplico por tiempo
                fixed offsetY = _ScrollYSpeed * _Time.x;//offset en y se agrego en una velocidad y se multiplico por tiempo
                fixed2 offsetUV = fixed2(offsetX, offsetY); //Se combinaron los dos fixed en un fixed2

                fixed2 mainUV = IN.uv_MainTex + offsetUV; //Se agrego la textura más el offset


                // Albedo comes from a texture tinted by color
                fixed4 c = tex2D(_MainTex, mainUV) * _Color; //textura más el col0r
                o.Albedo = c.rgb; 
                //o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
                o.Alpha = c.a;
                //o.Alpha = _Transparency;

            }
            ENDCG
        }
            FallBack "Diffuse"
}
