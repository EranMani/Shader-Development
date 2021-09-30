Shader "EranM/SimpleOutline"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range (.002, 0.1)) = .005
    }

    SubShader // Implement 2 passes. One with the geometry colored in red, and the other will be the geometry with the regular texture
              // Because we deal here with a vertex and a surface, the PASS tag is not needed
    {
        ZWrite off // --> When turning the zwrite off, you will not see it in the game view unless you change the render queue
                   // to transparent, to get it drawn on top of everything. Otherwise the background itself can overtake
                   // what you are drawing and therefore it gets lost in the depth
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        float _Outline;
        float4 _OutlineColor;

        struct Input
        {
            float2 uv_MainTex;
        };

        void vert(inout appdata_full v) {
            v.vertex.xyz += v.normal * _Outline;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }
        ENDCG // --------------FIRST PASS--------------

        ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG// --------------SECOND PASS--------------
    }
        FallBack "Diffuse"
}
