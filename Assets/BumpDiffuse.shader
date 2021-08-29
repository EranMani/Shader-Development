﻿Shader "EranM/BumpDiffuse"
{
    Properties
    {
        _myDiffuse("Diffuse Texture", 2D) = "white" {}
        _myBump("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myDiffuse;
        sampler2D _myBump;
        half _mySlider;

        struct Input
        {
            float2 uv_myDiffuse;
            float2 uv_myBump;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
            // UnpackNormal is Unity method to convert RGBA of the image into the XYZ of the normal 
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            // Keep the Z value 1 since you dont want to change the brightness of the normal image
            // Change the normal brightness by modifying the Z value
            // Change the amount of dark areas by modifying the X and Y values
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }

        ENDCG
    }

    FallBack "Diffuse"
}
