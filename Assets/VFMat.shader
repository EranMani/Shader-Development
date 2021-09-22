Shader "EranM/VFMat"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleUVX("Scale X", Range(1,10)) = 1
        _ScaleUVY("Scale Y", Range(1,10)) = 1
    }

    SubShader
    {   
        Tags { "Queue" = "Transparent" }
        GrabPass{} //  Grab a capture of all the pixels that are about to appear on the screen
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0; // When working with a material, it needs UV values so that the shader system knows how to put
                                       // the material or texture onto the surface of the mesh
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _GrabTexture;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ScaleUVX;
            float _ScaleUVY;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); // Create a set of UV values that can be used by the fragment shader
                                                      // The UV values are transformed by using the existing UV values from the
                                                      // vertex struct, along with the texture itself
                                                      // NOTE => UV values always range from 0 to 1
                o.uv.x = sin(o.uv.x * _ScaleUVX); // A sine function will produce a wave-like structure from the data that we feed it
                                      // This should create a ripple across the surface
                                      // NOTE => This wave effect can be used for something like a glass or something else that you
                                      // want to distort
                o.uv.y = sin(o.uv.y * _ScaleUVY);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 col = tex2D(_GrabTexture, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
