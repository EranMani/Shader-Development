Shader "EranM/StencilWindow"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        
        _SRef ("Stencil Ref", Float) = 1
        // Pull out all of the different functions you can use in the Comp statement
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp ("Stencil Operations", Float) = 2
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }
        
        ZWrite off
        ColorMask 0 // Turn off any coloring being written to the frame buffer

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

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
