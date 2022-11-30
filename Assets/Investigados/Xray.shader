Shader "Custom/Xray"
{
   
	Properties
	{
		_SilColor("Silouette Color", Color) = (0, 0, 0, 1)
	}

	SubShader
	{
		// Regular color & lighting pass
		Pass
		{
            Tags
			{ 
				"LightMode" = "ForwardBase" // allows shadow rec/cast
			}

			// Write to Stencil buffer (so that silouette pass can read)
			Stencil
			{
				Ref 4 //Siempre pasa el valor del buffer en 4
				Comp always // El stencil buffer test siempre retornara el pass
				Pass replace //Que se se cambie el valor del fragmento cuando se pase se cambie a 4
				ZFail keep //el fragment se seguira usando el z-buffer para las pruebas de profundidad
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma multi_compile_fwdbase // shadows
			#include "AutoLight.cginc"
			#include "UnityCG.cginc"

			
			float4 _LightColor0; // provided by Unity

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float3 texCoord : TEXCOORD0;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float3 normal : NORMAL;
				float3 texCoord : TEXCOORD0;
				LIGHTING_COORDS(1,2) // shadows
			};
			ENDCG
		}

		// Silouette pass 1 (backfaces)
		Pass
		{
			Tags
            {
                "Queue" = "Transparent"
            }
			// Won't draw where it sees ref value 4
			Cull Front // draw back faces
			ZWrite OFF // No funciona en el depth buffer o z-buffer
			ZTest Always //Siempre se dibujara por encima de los otros shaders
			Stencil
			{
				Ref 3 // Pasara el valor del buffer en 3
				Comp Greater
				Fail keep
				Pass replace //Que se se cambie el valor del fragmento cuando se pase se cambie a 3
			}
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			// Properties
			uniform float4 _SilColor;

			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;
				output.pos = UnityObjectToClipPos(input.vertex);
				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{
				return _SilColor;
			}

			ENDCG
		}

		// Silouette pass 2 (front faces)
		Pass
		{
			Tags
            {
                "Queue" = "Transparent"
            }
			// Won't draw where it sees ref value 4
			Cull Back // draw front faces
			ZWrite OFF // No funciona en el depth buffer o z-buffer
			ZTest Always
			Stencil
			{
				Ref 4 
				Comp NotEqual
				Pass keep
			}
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			// Properties
			uniform float4 _SilColor;

			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;
				output.pos = UnityObjectToClipPos(input.vertex);
				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{
				return _SilColor;
			}

			ENDCG
		}
	}
}
