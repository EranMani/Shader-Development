Shader "EranM/Rim"
{
    Properties
    {
        _Color ("Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir; // <-- Use view direction to calculate the dot product values
        };

        float4 _Color;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal)); // <-- The view direction is normalized to a value of 1 by using the 
                                                                           // 'normalize' method. When you do a dot product of both vectors being
                                                                           // a length of 1, the result values will be very clean between 1 and -1
                                                                           // The dot product values will be from -1 to 1
                                                                           // Flip the dot product result to control the outer edges of the model
                                                                           // Saturate will reduce the dot value between 0 and 1
            o.Emission = _Color.rgb * pow(rim, _RimPower); // <-- Change the rim color
                                                           // 'pow' method will increase the gradient effect of the rim
        }

        ENDCG
    }
    FallBack "Diffuse"
}
