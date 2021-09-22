Shader "EranM/ColorVF"
{
    // Use the vertex position of the mesh to color the vertex of the mesh
    // This couldnt be done using a surface shader since there is no access to the actual vertex data
    // With the surface shader you can use the UV values, normals, world positions and etc but not the absolute mesh positions
    SubShader
    {
        Pass // When using both vertex and fragment shaders together, you need to put them in a Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 color : COLOR; // Manipulate the color
                float4 vertex : SV_POSITION; // These vertices are the vertices that have been processed from world space into
                                             // the clipping space. That is why they need an extra structure
            };

            v2f vert (appdata v) // This runs on every vertex //NOTE ====> if you want to change the vertices color, do it here
                                                              // instead of the fragment, since here it takes less process amount
                                                              // because this effect over a smaller set of data then the fragment
                                // Also, if you want the color not to change when the mesh is moving, do it here instead in the fragment
            {
                v2f o; // This will be used by the fragment shader
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                o.vertex = UnityObjectToClipPos(v.vertex); // Convert world data, from appdata structure, into the clipping space struct
                                                           // The method squashes the data down into 2D 
                //o.color.r = (v.vertex.x + 5)/10; // This is the world x-coordinate that is coming in from the original data from the mesh
                                        // You can move the mesh and it wont affect how you have colored the surface
                                        // Color the mesh based on positive values, according to the positions of the vertices.
                                        // For negative positions you will end up with black, and for positive you will get the color
                                        // Play with the equation to get different results
                //o.color.g = (v.vertex.z + 5) / 10;
                return o; // This struct is returned and used in the grag method below as "v2f i"
            }

            fixed4 frag(v2f i) : SV_Target // It is the job of the fragment shader to do something, as long as it returns a color
            {                              // This runs on every pixel
                // fixed4 col = fixed4(0,1,0,1); // It is the color that gets returned that becomes this pixel value that is being processed
                // fixed4 col = i.color;
                fixed4 col; // You can also change the color of the vertices using the fragment struct
                // When working with the fragment, the vertices are processed in screen space, and this depends on the resolution amount
                // That means that quite large values are in the works here
                // It also means that now we will work with the X and Y axis, since we are working in clipped 2D space
                col.r = i.vertex.x/1000;
                col.g = i.vertex.y/1000;
                return col; // Return a color pixel value of green
            }
            ENDCG
        }
    }
}
