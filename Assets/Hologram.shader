Shader "EranM/Hologram"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader
    {
        // When running  one thing through the shader, it is 1 draw-call, so that is called a PASS
        // You can do multiple passes within a shader
        Tags { "Queue"="Transparent" }

        Pass // FIRST PASS
        {
            // Create a pass that writes depth data in to the Z-buffer
            Zwrite On
            ColorMask 0 // Dont write any colored pixels into the frame buffer in this first pass
            // ColorMask RGB // -> will write color data before the hologram effect drawin over the top
        }

        // For the second pass below, there will be Z data in there for it to call on, since it happend above in the first pass
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade // SECOND PASS

        struct Input
        {
            float3 viewDir;
        };

        float4 _RimColor;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10; 
            o.Alpha = pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
