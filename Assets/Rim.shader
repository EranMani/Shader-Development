Shader "EranM/Rim"
{
    Properties
    {
        _Color ("Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
        _Texture ("RGB Base", 2D) = "white" {}
        _StripeWidth ("Stripe Width", Range(0.5, 10)) = 1.0
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir; // <-- Use view direction to calculate the dot product values
            float3 worldPos; // <-- Gives the world position of the pixel that you are about to draw
            float2 uv_Texture;
        };

        float4 _Color;
        float _RimPower;
        sampler2D _Texture;
        float _StripeWidth;

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal)); // <-- The view direction is normalized to a value of 1 by using the 
                                                                           // 'normalize' method. When you do a dot product of both vectors being
                                                                           // a length of 1, the result values will be very clean between 1 and -1
                                                                           // The dot product values will be from -1 to 1
                                                                           // Flip the dot product result to control the outer edges of the model
                                                                           // Saturate will reduce the dot value between 0 and 1
            //o.Emission = _Color.rgb * pow(rim, _RimPower); // <-- Change the rim color
                                                           // 'pow' method will increase the gradient effect of the rim
            o.Emission = _Color.rgb * rim > 0.8 ? rim : 0; // <-- Add the rim multiplier value when normals are mostly not facing us
                                                           // if rim is below the specified value, multiply the RGB with 0, which
                                                           // will produce black color


            // o.Emission = rim > 0.5 ? float3(1,0,0) : 0; // <-- EXAMPLE 1
            // o.Emission = rim > 0.5 ? float3(1, 0, 0) : rim > 0.3 ? float3(0, 1, 0) : 0; // <-- EXAMPLE 2
            // o.Emission = IN.worldPos.y > 1 ? float3(0,1,0): float3(1,0,0); // EXAMPLE 3
                                                                              // Color vertices based on world position
            // o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0); // <-- EXAMPLE 4
            o.Emission = frac(IN.worldPos.y *(10 - _StripeWidth) * 0.5) > 0.4 ? float3(0, 1, 0)*rim : float3(1, 0, 0)*rim; // <-- EXAMPLE 5
                                                                                                // Used the rim value to add depth
                                                                                                // into the colors

            o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
