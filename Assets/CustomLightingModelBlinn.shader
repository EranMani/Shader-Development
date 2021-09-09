Shader "EranM/CustomLightingModel"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
        SubShader
    {
        Tags { "Queue" = "Geometry" }

        CGPROGRAM
        #pragma surface surf BasicLambert

        // lightDir -> The direction ths light is coming from
        // Attenuation -> The intensity of the lightsource when it hits the model
        half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            // _LightColor0 -> The color of the light that is going on in the scene and its defined in one of the lighting
            // <include files> for Unity shaders. It says 0 at the end, but it includes the color of ALL of the lights that are affecting
            // the object
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
