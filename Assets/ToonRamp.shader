Shader "EranM/ToonRamp"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp

        float4 _Color;
        sampler2D _RampTex;

        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) 
        {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5; // Used as the UV value pulling out the texture components that are in the ramp texture
                                        // Spreads the ramp texture across the model based on the direction of the light and normal
            float2 rh = h; // rh contains 2 values to use according to the ramp texture
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
