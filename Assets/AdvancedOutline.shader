Shader "EranM/AdvOutline"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range (.002, 0.1)) = .005
    }

    // This is not going to draw the outline first and then the model over the top
    // Put this over the top of the existing model and the oultine is going to show up around the outside, but it is also going to show
    // up around any other highlighted bits of geometry 
    SubShader          
    {  
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
        ENDCG
        

        Pass {
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f{
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };

            float _Outline;
            float4 _OutlineColor;

            v2f vert(appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal)); // Calculate a normal based on the world position
                                        // By multiplying it by the UNITY_MATRIX_IT_MV, it will give that world position value
                                        // It is retruning the normal in the form of a world coordinate, rather then the normals that
                                        // belong to the vertex, which would be the ones in the local space

                float2 offset = TransformViewToProjection(norm.xy); // Calculate an offset based on the normals xy position by transforming
                                        // it into projection. Take it from the world and then projecting it into the view (clipping space)
                o.pos.xy += offset * o.pos.z * _Outline;
                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
                return i.color;
            }
            ENDCG          
        }          
    }
    FallBack "Diffuse"
}
