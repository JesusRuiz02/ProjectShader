Shader "Custom/Timer4"
{
    Properties
    {
       _MainTex("Base (RGB)", 2D) = "white" {}
       _Color("Color", Color) = (1,1,1,1)
       _BumpMap("BumpMap",2D) = "bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma  surface surf Lambert 
        
        #pragma target 3.0

         sampler2D _MainTex;
         sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D(_BumpMap, IN.uv_BumpMap);
            o.Albedo = (a * b) * _Color ;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
