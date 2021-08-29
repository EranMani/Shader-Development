Shader "EranM/SolutionChallenge2"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Range("Range", Range(0,5)) = 1
        _Tex("Texture", 2D) = "white" {}
        _Cube("Cube", CUBE) = ""{}
        _Float("Float", Float) = 0.5
        _Vector("Vector", Vector) = (0.5,1,1,1)
    }

        SubShader
        {
            CGPROGRAM
            #pragma surface surf Lambert 

            fixed4 _Color;
            half _Range;
            sampler2D _Tex;
            samplerCUBE _Cube;
            float _Float;
            float4 _Vector;

            struct Input
            {
                float2 uv_Tex;
                float3 worldRefl;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                // Grab all UV values that the model have and slapping the texture onto it with the tex2D function
                // Takes the input texture, and using the UV values to output the albedo colors for the model
                // Use the range to as multiplier determine the color amount on the model
                o.Albedo = (tex2D(_Tex, IN.uv_Tex) * _Range).rgb;
            }

            ENDCG
        }
            FallBack "Diffuse"
}
