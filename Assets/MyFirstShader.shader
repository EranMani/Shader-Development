Shader "EranM/HelloShader" { // <-- Shader name and in which folder it will be placed in the shaders menu

	Properties{ // <-- Declare input fields as variables. They will be shown in the inspector
		_myColor ("Example Color", Color) = (1,1,1,1)
		_myNormal("Example Normal", Color) = (1,1,1,1)
		_myEmission("Example Emission", Color) = (1,1,1,1)
	}

	SubShader{ // <-- Mix input properties with geometry information, surface coloring and lights

		CGPROGRAM // <-- Start tag of the code
			// #pragma surface -> Compile a surface shader
			// surf -> Name of the function containing the surface shader
			// Lambert -> Type of light to use
			#pragma surface surf Lambert

			struct Input { // <-- Declares the input data that will be required by the function
						   // <-- This can include vertex, normal, UV and other information about the models mesh
				float2 uvMainTex;
			};

			fixed4 _myColor;     // <-- To access any property created, list them and the type of data then contain
			fixed4 _myEmission;	 // <-- Refer to the property by the name. fixed4 is a special shader data type (array of 4 values)
			fixed3 _myNormal;

			void surf(Input IN, inout SurfaceOutput o) { // <-- The shader function. It takes in the input structure declared,
														 // <-- as well as a structure specifying the type of output data to be expected
														 // <-- The output structure changes depending on the lighting model used
														 // <-- In this case, the lighting is lambert and therefore the output is the
														 // <-- surface output struct
				o.Albedo = _myColor.rgb;				 // <-- The albedo field of the struct is modified according to the property
				o.Emission = _myEmission.rgb;
				o.Normal = _myNormal.rgb;
			}

		ENDCG // <-- End tag of the code
	}

	Fallback "Diffuse" // <-- A basic less GPU heavy effect to use on the surface of the model, should the machine the shader is
					   // <-- unning on be incapable of running your code
}