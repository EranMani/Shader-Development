Shader "EranM/StandardPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {} // Use map to figure out which parts will be shiny and which ones dont
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Emission ("Emission", Range(0,9)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Geometry" }

        CGPROGRAM
        #pragma surface surf Standard 

        struct Input
        {
            float2 uv_MetallicTex;
        };

        sampler2D _MetallicTex;
        half _Metallic;
        half _Emission;
        fixed4 _Color;


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex);
            o.Metallic = _Metallic;
            o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r * _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
