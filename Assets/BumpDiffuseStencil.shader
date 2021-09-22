Shader "EranM/BumpDiffuseStencil"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Bump("Bump Texture", 2D) = "bump" {}
        _Slider ("Bump Amount", Range(0,10)) = 1

        _SRef("Stencil Ref", Float) = 1
        // Pull out all of the different functions you can use in the Comp statement
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operations", Float) = 2
    }
    SubShader
    {
        Stencil
        {
            // Tell the other object which stencil we want it to line up with
            Ref[_SRef]
            Comp[_SComp]
            Pass[_SOp]
        }

       CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _Bump;
        half _Slider;
        float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bump;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color.rgb;
            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
            o.Normal *= float3(_Slider, _Slider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
