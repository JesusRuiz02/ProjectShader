Shader "Custom/Timer3"
{
    Properties
    {
       _BumpMap("Normal Tex", 2D) = "bump" {}
       _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert 
        #pragma target 3.0
           float4 _Color;
         sampler2D _BumpMap;
        struct Input
        {
            float2 uv_MainTex;
             float2 uv_BumpMap;
        };
        void surf (Input IN, inout SurfaceOutput o)
        {
             o.Albedo.rgb = tex2D(_BumpMap, IN.uv_BumpMap)* _Color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
