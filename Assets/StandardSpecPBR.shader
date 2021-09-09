Shader "EranM/StandardSpecPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {} // Use map to figure out which parts will be shiny and which ones dont
        _SpecColor ("Specular", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Geometry" }

        CGPROGRAM
        #pragma surface surf StandardSpecular

        struct Input
        {
            float2 uv_MetallicTex;
        };

        sampler2D _MetallicTex;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex);
            o.Specular = _SpecColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
