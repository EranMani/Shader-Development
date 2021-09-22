Shader "EranM/VFDiffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            Tags {"LightMode"="ForwardBase"} // Set-up the lighting for forward rendering, so that the lights are calculated on a per
                                             // model basis
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc" // Include this file when using properties from the lights

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0; // The color produced for the lighting that we do in the calculation
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                half3 worldNormal = UnityObjectToWorldNormal(v.normal); // Convert the normal that is on the mesh, which will be in local
                                                                        // space (to the mesh) into its actual coordinates in the real world
                                                                        // That is the only way to compare that normal against where
                                                                        // the world position of the light is. They both have to be
                                                                        // in the same coordinate space
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz)); // _WorldSpaceLightPos0 holds on to the position of the
                                                                              // light that is in the scene
                o.diff = nl * _LightColor0; // _LightColor0 belongs to the include file and it holds the color of the light in the scene
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                col *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}
