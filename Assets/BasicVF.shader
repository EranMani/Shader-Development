Shader "Unlit/BasicVF"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM // The CGPROGRAM in this case is enclosed in a Pass block
            #pragma vertex vert // The required compiler directive for vertex followed by the name of the vertex function
            #pragma fragment frag // The required compiler directive for fragment followed by the name of the fragment function
            #pragma multi_compile_fog // Allows for the use of fog effects. Should be removed if no fog is needed

            #include "UnityCG.cginc" // This file contains all the pre-written methods and variable definitions that will make
                                     // the shader writing much easier
                                     // The file can be found in => <program_files>/Unity/Editor/Data/CGIncludes/
            
            // Hold the data for the vertex shader
            struct appdata // This contains information about each vertex
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            }; // The total sum of values that can be accessed, can be found in the appdata_full struct which is in the unitycg.cging
               // It is also possible to assign a color to each vertex, as well as get its tangent (a vector that sits across
               // a vertex at 90 degrees to its normal)
               // The property names are inconsequential, however the keywords in capital are important
               // The capital keywords are recognized by the graphics card
        
            // Hold the data for the fragment shader
            struct v2f 
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex; // sampler2D given by Unity for any texture // this one is in the fragment shader
            float4 _MainTex_ST; // This float contains scaling data for the texture // this one is in the vertex shader

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); // _MainTex_ST
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv); // _MainTex
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
