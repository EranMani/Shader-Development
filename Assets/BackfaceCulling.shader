Shader "EranM/BackfaceCulling"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off // You can cull the front side, the back side or turn of culling completely
                 // Culling the back side is the default setting
                 // Control whether you see or dont see the back face of a polygon
        Pass
        {
            SetTexture [_MainTex] {combine texture}
        }
    }
   
}
