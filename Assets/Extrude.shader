Shader "EranM/Extrude"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amount ("Extrude Amount", Range(-1,1)) = 0.01
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert // Find the vertex shader as well

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0; // The UV value, and its required since the surface function is putting a texture onto the surface
        };

        sampler2D _MainTex;
        float _Amount;

        // The vertex shader that will manipulate the vertices of the model
        // It doesnt move them physically. It moves them as far as the rendering is concerned
        void vert(inout appdata v) { 
            v.vertex.xyz += v.normal * _Amount; // Grab the xyz position of each vertex and add normal to it, multiplied by amount
                                            // The normal length is going to be of 1, so the number multiply is there to reduce the 
                                            // normal amount or increase it
        }


        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
