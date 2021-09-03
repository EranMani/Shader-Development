Shader "EranM/DotProduct"
{
 
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

 

        sampler2D _MainTex;

        struct Input
        {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            half dotp = dot(IN.viewDir, o.Normal); // <-- Calculate the dot product for the view direction vector against the normal vector
            // half dotp = 1-dot(IN.viewDir, o.Normal); // <-- Flip the dot product result to get opposite result

            // Use dot product value to adjust the 'r' channel. When the view direction vector is parallel with normal you will get 
            // a dot value of 1 because you are going to get the dot product of one of two vectors that are going in excatly
            // the same direction and that will give a color of (1,1,1) which is white
            //o.Albedo = float3(dotp, 1, 1);
            o.Albedo.gb = float2(1-dotp, 0);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
