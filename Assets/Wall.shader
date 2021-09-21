Shader "EranM/Wall"
{
    Properties
    {
        _MainTex("Diffuse", 2D) = "white" {}
    }
        SubShader
    {
        Tags { "Queue" = "Geomtery" }

        Stencil
        {
            Ref 1
            // If the stencil ref 1 is not equal to what is already in the stencil buffer then it will keep those pixels
            Comp notequal
            // If it finds a 1 in the stencil buffer for this pixel then dont draw, but if it is not equal to 1 then do it
            // Keep everything where there is not a 1 in the stencil buffer
            Pass keep
        }

        CGPROGRAM
        #pragma surface surf Lambert


        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
        FallBack "Diffuse"
}
