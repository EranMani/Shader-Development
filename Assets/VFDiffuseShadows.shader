Shader "EranM/VFDiffuseShadows"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            // Shadow receiving
            Tags {"LightMode"="ForwardBase"} // Set-up the lighting for forward rendering, so that the lights are calculated on a per
                                             // model basis
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight // Adding information about NOT including
                                           // the given maps (lightmap, direction lightmap etc...)
                                           // This will ignore the given maps so that you can accept a shadow
                                           // It will allow to take over the shadow processing yourself
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc" // Include this file when using properties from the lights
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

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
                // float4 vertex : SV_POSITION;
                float4 pos : SV_POSITION;
                SHADOW_COORDS(1) // Calculate the coordinates for the shadows on the shader object
            };

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                // o.vertex = UnityObjectToClipPos(v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                half3 worldNormal = UnityObjectToWorldNormal(v.normal); // Convert the normal that is on the mesh, which will be in local
                                                                        // space (to the mesh) into its actual coordinates in the real world
                                                                        // That is the only way to compare that normal against where
                                                                        // the world position of the light is. They both have to be
                                                                        // in the same coordinate space
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz)); // _WorldSpaceLightPos0 holds on to the position of the
                                                                              // light that is in the scene
                o.diff = nl * _LightColor0; // _LightColor0 belongs to the include file and it holds the color of the light in the scene
                TRANSFER_SHADOW(o) // Use the v2f structure, that is looking for something called 'pos'. It wont accept vertex
                                   // Transfer the shadows from world space into a structure that the fragment can use
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Calculate the shadow pixels, which are going to be dark spots
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed shadow = SHADOW_ATTENUATION(i);
                col.rgb *= i.diff * shadow; // Multiple the shadow pixels with the diffuse to put it into the color
                return col;
            }
            ENDCG
        }

        Pass
        {
            // Shadow casting
            // Shadows:
            // Shadows are a flat thing on the surface of something
            // Instead of projecting something forward into the clipping space and making it flat for the screen
            // you cast it backwards and making it flat on whatever object it lands on
            // The whole outside silhouette of the object is being projected onto all the surfaces and then where the extreme of those are,
            // they are colored in and that is what a shadow is

            // The shadow that cast onto another object is caused by this shader alone

            Tags {"LightMode" = "ShadowCaster"} // Cast shadow into the objects around it based on where the light is projecting the shadow to
            // This pass will not add shadows onto the casting object itself, but only onto the other objects near him
                                            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster // Tell the shader to activate shadows  
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                V2F_SHADOW_CASTER; 
            };

            v2f vert(appdata v)
            {
                v2f o; // Output of the v2f
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)  // Take the geometry from the model by using the appdata struct above. 
                                                        // The appdata is being transformed into the shadow caster by our vertex shader code
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i) // Spit the shadow out as far as the pixel color is concerned for that particular pixel
            }
            ENDCG
        }
    }
}
