Shader "EranM/PackedPractice"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert 

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;


        void surf (Input IN, inout SurfaceOutput o)
        { 
            //o.Albedo = _Color.rgb;
            // o.Albedo = _Color.bgr; // <-- Albedo is fixed3(3 values), because _Color is fixed4(4 values) we take from it three values
            // o.Albedo.r = _Color.r; // Same as => o.Albedo.x = _Color.x <=
            // o.Albedo.r = _Color.x; // Fine as well
            // o.Albedo.rb = _Color.xy; // Fine as well
            // o.Albedo.rb = _Color.xg; // Will not work!
        }
        ENDCG
    }
    FallBack "Diffuse"
}
