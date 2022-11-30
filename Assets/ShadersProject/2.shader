Shader "Unlit/2"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _MainColor("Main Color", Color) = (1,1,1,1)
        _XPosition("X Position", Float) = 0
        _ZPosition("Z Position", Float) = 0
        _Transparency("Transparency", Range(0,1)) = 1

    }
        SubShader
    {
        Tags { "Queue" = "Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _MainColor;
            float4 _MainTex_ST;
            float _XPosition;
            float _ZPosition;
            float _Transparency;
            sampler2D _MainTex;

            struct appdata
            {
                float4 vertex:POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 clipPos:SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                if (v.vertex.y > 0) { //si el vertex en y es mayor a 0
                    v.vertex.x = _XPosition; // mueve el vertex en x y z
                    v.vertex.z = _ZPosition;
                }
                o.clipPos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); //juntas los vertex con la textura
                return o;
            }
            fixed4 frag(v2f i) : SV_Target
            {
                //return _MainColor;
                fixed4 col = tex2D(_MainTex, i.uv) + _MainColor;
                col.a = _Transparency;
                return col;
            }
            ENDCG
        }
    }
}
