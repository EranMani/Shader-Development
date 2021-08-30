Shader "EranM/BumpedEnvironment" 
{
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,10)) = 1
        _myBright ("Brightness", Range(0,10)) = 1
        _myCube ("Cube Map", CUBE) = "white" {} // <-- Empty brackets for initialization. "white" for default color value
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuse;
        sampler2D _myBump;
        half _mySlider;
        half _myBright;
        samplerCUBE _myCube;

        struct Input {
            float2 uv_myDiffuse;
            float2 uv_myBump;
            // Unity wont let you use the world reflection data while trying to modify the normals, because the normals are based 
            // on the world reflection data - this means that you want to be able to modify the normals but not affect the world
            // reflection data, becuase they are kind of linked together
            // The way to do that is by using INTERNAL_DATA so that it will use a different data set
            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _myBright;
            o.Normal *= float3(_mySlider,_mySlider,1);
            // WorldReflectionVector -> calculates a world reflection vector from the input structure data, given the normals
            // of the model itself
            o.Emission = texCUBE (_myCube, WorldReflectionVector (IN, o.Normal)).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }