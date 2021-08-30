Shader "EranM/BumpedEnvironmentChallenge"
{
    Properties
    {
        _Normal ("Normal Map", 2D) = "bump" {}
        _Cube("Cube Map", CUBE) = "white" {}
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _Normal;
        samplerCUBE _Cube;

        struct Input
        {
            float2 uv_Normal;
            float3 worldRefl; INTERNAL_DATA
        };


        void surf(Input IN, inout SurfaceOutput o)
        {
             o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Normal)) * 0.3;
             o.Albedo = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
