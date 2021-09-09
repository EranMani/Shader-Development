Shader "EranM/CustomLightingModelBlinn"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
        SubShader
    {
        Tags { "Queue" = "Geometry" }

        CGPROGRAM
        #pragma surface surf BasicBlinn

        // lightDir -> The direction ths light is coming from
        // Attenuation -> The intensity of the lightsource when it hits the model
        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 h = normalize(lightDir + viewDir); // Halfway vector required, is between the light direction and the viewer
                                                     // direction by adding the two vectors together
            half diff = max(0, dot(s.Normal, lightDir)); // Diffuse value for coloring  
                                                         // The closer the surface normal and the light direction are, the stronger
                                                         // that point will be
            float nh = max(0, dot(s.Normal, h)); // Gives the strength or fall-off of the specular component
                                                 // The specular component needs to be around that 'h' (halfway vector) value
                                                 // because of the way that the light refracts from the surface
            float spec = pow (nh, 48.0); // 48 is what Unity uses

            half4 c; // Color of the pixel, including the alpha value as well
            // c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0 * spec) * atten;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
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
