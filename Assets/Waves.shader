Shader "EranM/Waves"
{
    Properties
    {
        _MainTex("Diffuse", 2D) = "white" {}
        _Tint ("Color Tint", Color) = (1,1,1,1)
        _Freq ("Frequency", Range(0,5)) = 3
        _Speed ("Speed", Range(0, 100)) = 10
        _Amp ("Amplitude", Range(0,1)) = 0.5
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        float4 _Tint;
        float _Freq;
        float _Speed;
        float _Amp;

        struct Input
        {
            float2 uv_MainTex; // UV for main texture
            float3 vertColor; // Add vertex color based on the vertices
        };

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        void vert(inout appdata v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed; // The _Time is a unity-created variable. It changes with the time, as the program runs
                                      // Used speed to speed up time of the waves
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t * 2 + v.vertex.x * _Freq * 2); 
                                      // Height value that will be given to the vertex to lift up or down
                                      // Working across the x-direction. Used frequency to squish or spread the waves
                                      // Multiply by the _Amp to lift the waves up or push them down
            v.vertex.y = v.vertex.y + waveHeight; // Use the waveHeight as an offset from the existing position of the mesh
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z)); // When modifying a mesh by playing with its
                                      // vertices, you need to update the normals as well to reflect the changes made in the vertices
            o.vertColor = waveHeight + 2; // Set the vertex color. When wave it at its lowest, its going to be -0 type value and the +2
                                          // is used to picking it up a little to get some gradient color changes over the wave
        }
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c * IN.vertColor.rgb; // The albedo color is being set by multiplying the texture color with the vertex color
                                             // that was calculated in the vertex shader
        }
        ENDCG
    }
    FallBack "Diffuse"
}
