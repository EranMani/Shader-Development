Shader "EranM/BasicLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
       // _SpecColor ("Specular Color", Color) = (1,1,1,1) // Color of the light that you will see in the specular reflection
       // _Spec ("Specular", Range(0,1)) = 0.5 // Control the size of the specular things
       // _Gloss ("Gloss", Range(0,1)) = 0.5 // The power applied to the specular
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
        //half _Spec;
        //half _Gloss;
        // The spec color is already defined by Unity, therefore there is no need to redefine it here
     
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
           // o.Specular = _Spec;
            //o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
