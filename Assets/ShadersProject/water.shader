Shader "Custom/1"
{
    Properties
    {
        
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo Text", 2D) = "white" {}
        _BumpMap("BumpMap", 2D) = "Bump" {}
        _Transparency("Transparency", Range(0.0,0.5)) = 0.25
        _CutOut("CutOut", Range(0.0,1.0)) = 0.2
        _Distance("Distance", Float) = 1
        _Amplitude("Amplitude", Float) = 1
        _Amplitudee("Amplitude", Float) = 1
        _Speed("Speed", Float) = 1
        _Speedd("Speed", Float) = 1
        _Amount("Amount", Float) = 1
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha
            Pass
            {
                CGPROGRAM
                //#pragma surface surf Lambert vertex:vert
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                struct appdata
                {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal: NORMAL;
                };

                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };

                sampler2D _MainTex;
                sampler2D _BumpMap;
                float4 _MainTex_ST;
                float4 _Color;
                float _Transparency;
                float _CutOut;
                float _Distance;
                float _Amplitude;
                float _Amplitudee;
                float _Speed;
                float _Speedd;
                float _Amount;

                v2f vert(appdata v)
                {
                    v2f o;
                    v.vertex.y += sin(_Time * _Speedd + v.vertex.y * _Amplitude) * _Distance * _Amount;
                    v.vertex.x += sin(_Time * _Speedd + v.vertex.x * _Amplitude) * _Distance * _Amount;

                    float waveHeight = sin(_Time * _Speed + v.vertex.x * _Amplitudee) * _Amplitudee;
                    float waveHeightz = sin(_Time * _Speed + v.vertex.z * _Amplitudee) * _Amplitudee;
                    v.vertex.y = v.vertex.y + waveHeight + waveHeightz;
                    v.normal = normalize(float3(v.normal.x, v.normal.y, v.normal.z));
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 col = tex2D(_MainTex, i.uv) + _Color;
                    col.a = _Transparency;
                    clip(col.r - _CutOut);
                    return col;
                    
                }
                
                ENDCG
            }
        }
}

       