Shader "EranM/Hole"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
    }
    SubShader
    {
        // Get to the stencil buffer first
        Tags { "Queue"="Geometry-1" }

        // Make the object invisible
        ColorMask 0
        ZWrite off

        Stencil
        {
            // Put a value of 1 on each pixel that belong to the object
            Ref 1
            // Check what is already in the stencil buffer in order to not overwriting pixels that are already in
            // Use the comparison operator to do a comparison between 1 and whatever is in the stencil buffer
            Comp always
            // Tell what happens with those pixels that belong to the object with respect to drawing it into the framebuffer
            // Pass is doing one draw call
            // Replace anything that is in the frame buffer with this pixel pass
            Pass replace
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
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
