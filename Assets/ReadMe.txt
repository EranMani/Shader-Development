* Rendering Pipeline
	- Rendering is the process of drawing a sene on the computer screen. It involoves mathmetical combination of geometry, textures, surface treatments, the viewers perspective
	  and lighting
	- It is also referred to as the graphics pipeline, represents the flow of processes that take place to get a virtual environment drawn onto the computer screen
	- There are three phases to the pipeline:
		1) Application - runs on the CPU and involves all the processes that occur in the software, including moving objects, collisions, input etc
		2) Geometry - determines how the virtual world is situated with respect to the player. It involves calculations about the position of the camera, the rotation, transformations,
		              and scaling of the world and all the polygons
		3) Rasterisation - gets the world out of the computer and onto the screen. It involves processing the environment numerous times to draw it out, with different filters that
						   are then added together to produce a final image
						   
						   
		* Graphics pipeline	
			- It is named the geometry and rasterisation processes, which involves:
				1) Geometry - the geometry is processed and the vertices of the polygons collected
				2) Illumination - where the models are colored and lit.
				3) Viewing Perspective - Before making it onto the computer screen, the model is then processed through a viewing perspective that considers how the camera
										 is set up, including whether or not it is in perspective or orthigraphic, as well as details like the field of view
				4) Clipping - remove any details outside of the camera's viewing volume
				5) Screen Space Projection - projection of the 3D object onto 2D space
				6) Rasterisation - any post-processing effects are added during the rasterisation process. These are extra visual effects that occur to the 2D version of the image,
								   and not in 3D space. It includes things like depth of field, bloom and more
								   
	- The reason that geometrical transformations and viewer perspective are so important in rendering, is that the algorithms model lighing in the real world and examine how lighting
	  is reflected off the surface of an object with respect to the location of the viewer
	  
* Shaders in Unity are written in a language called ShaderLab. It strecthes the code into logical segments to allow you to: 
	1) declare properties - declare input fields to use as variables in your shader processing. These will have their own editor formatiing to determine how they will show up
							in the inspector
	2) write shader processing code - where the magic happens. you mix the inputted properties with model geometry information, surface coloring and lights to produce the final
									  effect. The program language called CG, or HLSL (High Level Shader Language).
									  It begins with a CGPROGRAM block. These mark the start and end tags for your code.
	3) specify fallback functions for when the graphics card might not be able to handle the code that you have written
	
	
* Vector Mathematics
	- A vector is a line that has a length and a direction (denoted by an arrow). It can be used to represent measurements such as displacement, velocity and acceleration
	  It is a change in location of coordinates, with the values of the vector represeting the amounts of coordinate change.
	  The vector between two points can be calculated like this: (P2x - P1x, P2y - P1y) > P2(3,4) P1(1,1) > (3-1,4-1) = (2,3) as the vector
	  
	- A vector does not specify a fixed starting location. It can start and end anywhere, depending on its application. If there was a point R = (1,2), the vector 'v' could be
	  added to this point as directions to a new point, T. To determine the location of T, add R and 'v' like this: T = R + v > R(1,2) v(2,3) > T = (3,5)
	  
	- It is often useful to know the length of a vector. The length of vector 'v' would tell us the distance between point R and T. The length of a vector, denoted ||v|| is found
	  by Pythagoras Theorem:     ___________    __________
								√vx^2 + vy^2 = √2^2 + 3^2 = 3.6
								
	- Sometimes it is necessary to scale a vector so that it has a unit length. Therefore, the length of the vector is equal to 1. 
	  The process of scaling the length is called normalizing , and the resultant vector (which still points in the same direction) is called a UNIT VECTOR.
	  To find the normalized form of a vector:       v
												v =  -
												   ||v||   # The equation divides the original vector by its length to the calculate the unit vector. 
														   # The unit vector for 'v' will be: v^ = (2/3.6, 3/3.6) = (0.556, 0.833)
														   
	- Dot product: used to calculate the angle between two vectors. It is calcaulted by taking two vectors 'v' and 'w', and multiplying their respective coordinates together,
				   then adding them. The dot product results in a single value: v * w = vx*wx + vy*wy > v(2,3) w(5,1) > 2*5 + 3*1 = 13
				   # What does the value 13 means? the most useful application of the dot product is working out the angle between two vectors. Just by knowing the value of the
				     dot product you can determine how the vectors sit with relation to each other:
						- If the dot product is greater then 0 -> the vectors are less then 90 degress apart
						- If the dot product equals 0 -> the vectors are perendicular
						- If the dot product is less then 0 -> the vectors are more then 90 degress apart
						
	- To determine the exact angle between two vectors, the ARCCOSINE of the DOT PRODUCT of the unit vectors is found. The resulting value is the angle between the vectors:
		angle = cos^-1(v^ * w^) ---- NOTE: v^ means the vector normalized value, or unit ----
		
	- Cross product: when calcaulting the angle between vectors using the dot product, the cross product can determine to turn clockwise or counterclockwise.
					 The cross product of two vectors results in another vector. The resulting vector is perendicular to btoh the initial vectors.
					 The cross product is defined only for three dimensions.
					 The cross product of two vectors 'v' and 'w', denoted v x w will be: v x w = (vy*wz - vz*wy)*(1,0,0) + (vz*wx - vx*wz)*(0,1,0) + (vx*wy - vy*wx)*(0,0,1) 
					 # The first part determines the value of the x-coordinate of the vector, because the unit vector (1,0,0) has a value only for the x-coordinate. The same
					   occurs in the other two parts for the y and z coordinates
					   
	- To find the cross product of two 2D vectors, the vectors first must be converted into three-dimensional coordinates. Just add the 0 value to the vectors that dont have a value in the z-direction
		# v(2,3) > v(2,3,0)
		# v(5,1) > v(5,1,0)
		# (3*0 - 0*1)*(1,0,0) + (0*5 + 2*0)*(0,1,0) + (2*1 - 3*5)(0,0,1) = 0(1,0,0) + 0(0,1,0) + (-13)(0,0,1) = (0,0,0) + (0,0,0) + (0,0,-13) = (0,0,-13)
		# For (0,0,-13) -> if the Z is positive it means a counterclockwise turn, and if the Z is negative it means a clockwise turn
		
		
	- Some links for future reference:
		1) https://www.habrador.com/tutorials/math/1-behind-or-in-front/
		
		
#####################################################################################
################################# SHADER ESSENTIALS #################################
#####################################################################################

----------------------------- Variables & Packed Arrays -----------------------------
* Shader code is quite different. It uses the Unity ShaderLab to write the code. We are writing enough code to compile into a shader 
* Shader code is executed on a per-vertex or per-pixel basis. That means that the code you write, you write as though you are only writing for one pixel. You dont need to write 
  loops that process all of the pixels that need to appear on the screen. The GPU does the rest.
* Another difference between normal code like C# and shaders are the variables and arrays. Shader code has similar data types but they have been designed to be more efficient
	- (Shader) float: highest precision, 32 bits like a regular c# float. Used for world positions, texture coordinates and calculations
	- (Shader) half: half sized float, 16 bits. Used for short vectors, directions and dynamic color ranges
	- (Shader) fixed: lowest precision, 11 bits. Used for regular colors and simple color operations
	- (Shader) int: used for counters and array indices
	
* There are also data types for textures:
	- sampler2D: used for regular images
	- samplerCUBE: used for cube maps
	
	- Each of these has a high ad low precision version:
		* Low precision -> sampler2D_half
						   samplerCUBE_half
		* High precision -> sampler2D_float
							samplerCUBE_float
							
* Any of these data types can be made into special arrays used in shaders PACKED ARRAYS. To create a packed array, the syntax only requires a number representing the length 
  of the array to be placed on the end of the data type name. Values can be placed into the array when the array is declared using a bracketed string of values
	- Example: fixed4 color1 = (0,1,1,0)
	- In a packed array, the values are accessed more like those you get out of a structure. 
	  In an array of length 4, the values can be accessed using r,g,b,a OR x,y,z,w ==> fixed4 color1 = (0,1,1,0), color1.r = 0, color1.x = 0, color1.r == color1.x
	- With packed arrays, you can put multiple values into them in one line, as well as being able to copy values between different sized packed arrays
		fixed3 color3;
		color3 = color1.rgb => assign to color3 the first 3 values of the color1 variable
	- When listing indices, you can not mix up the sets. However, you can reorder the indices to put the array values in a different order
	- Smearing: process of filling all positions in the array with the same value, using a single value
	- Masking: when dealing with packed arrays to copy over as many values as you like from one array to another, in any order
	
* Many calculations in computer graphics require data structures bigger then arrays and therefore use MATRICES. Information for world geometry states, transformations, rotations
  and scales are all performed by matrices. For that, shaders have another data structure called a PACKED MATRIX.
	- A packed matrix is declared using the data type followed by the number of rows multiplied by the number of columns => float4x4 matrix;
	- Accessing individual values in the matrix is achieved using _mRowColumn => float myValue = matrix._m00;
	- Packed matrices also have shortcuts for getting at the values contained within. A syntax called CHAINING allows you to specify a string of values from a matrix to go into an array.
	- Example: 		fixed4x4 matrix;
						CHAINING
			fixed4 color = matrix._m00_m01_m02_m03
	- It is also possible to grab an entire row of values using the row index and put them directly into an array of the same size => fixed4 color = matrix[0]
	
----------------------------- The Anatomy Of A Mesh And Shader Input -----------------------------
* The most efficient way to store a mesh is by using triangles, therefore most models will be constructed from them.
  A triangle is also referred to as a polygon. It has three vertices, one in each corner, with a coordinate representing its location in 3D space, a flat surface connecting the 
  vertices and a surface normal.
  Each vertex also has its own normal.
  A normal is a vector extending from the point of origin at 90 degrees to the surface. Normals are especially important in computer graphics as they indicate the side of the polygon that
  the texture should be applied to. They are also calculating how an object is shaded by determining how light hits the surface.
  
* A mesh is stored as a series of ARRAYS that store all the information about the vertices and normals:
	1) Vertex array: holding each corners 3D coordinates. The coordinates of every vertex are listed here.
	2) Normal array: holding each of the vertices normals. For each of the vertices, a normal is also recorded in here
	3) UV array: specifies how a texture is wrapped onto a model. It indicates how different parts of a 2D texture are mapped to each 3D vertex. UV's are specified in 2D space
	4) Triangle array: array of each individual polygon triangle. It lists vertices in groups of three, where each tuple represents a single triangle making up the surface of the mesh
	
* UV's represents a point on a texture that is mapped to a point on a polygon. It is represented by the letters u,v and w. The 'w' is only used internally for calculations, which leaves
  the UV as a 2D value and also gives the UV its name.
	- UV values fall between 0 and 1. No matter how big the texture, 0 represents the smallest pixel value in the image and 1 the largest. Think of it like a percentage rather then an
		exact location
	- UV's belong to each vertex and are always ordered in anti-clockwise order on the face in which the normal faces the viewer
	- Note: not all the texture needs to be applied to the polygon and that is the very purpose of UV's
	- Meshes can have more then one set of UV's. This can be the case when more then one image is applied over its surface. In Unity, 2 sets of UV's are allowed. UV's can be added
	  programmatically, but are usually specified inside 3D modeling packages at the time the model has the texture applied.
	  
* Options to grab data about the mesh	
	1) Get hold of the UV values with 'uv' or 'uv2', followed by the name of the texture. This data can be used to put a texture onto the mesh
		==> float2 uv_MainTex;
		==> float2 uv2_MainTex;
	2) Information about the angle at which a model is being viewed from by using the 'viewDir'. This allows to write shaders that can change the surface of a model depending on where
	   the camera is.
		==> float3 viewDir;
	   One example of this is rim lighting
	3) Get the coordinates of the vertex being processed by using 'worldPos', which allows to perform operations on the shader based on the world location
		==> float3 worldPos;
	   An example of this would be to show or not to show, a material on the surface of an object based on its physical world location
	4) Information on how to reflect an image off the surface of a model. This comes in handy if you want to create a shiny looking object that has a mirror finish
		==> float3 worldRefl;
		
* SUMMARY: the 3D mesh has many values that are required to manipulate how a material will visually present on a surface, and it is the job of the input struct to get these values
		   to your shader function
		   
		   
----------------------------- Shader Properties -----------------------------
* Properties are the way we get values from the inspector into the shader
* The list of available properties are:
	1) _myColor("Example Color", Color) = (1,1,1,1)
	2) _myRange("Example Range", Range(0,5)) = 1
	3) _myTex("Example Texture", 2D) = "white" {}
	4) _myCube("Example Cube", CUBE) = "" {} => to achieve things like environment reflections
	5) _myFloat("Example Float", Float) = 0.5
	6) _myVector("Example Vector", Vector) = (0.5,1,1,1)
	
* Each property type is stored as one of the data type:
	1) fixed4 _myColor;
	2) half _myRange;
	3) sampler2D _myTex;
	4) samplerCUBE _myCube;
	5) float _myFloat;
	6) float4 _myVector;
	
	
	
#######################################################################################
############################### Illuminating Surfaces #################################
#######################################################################################

----------------------------- Lambert And Lighting -----------------------------
* A lighting model is used to calculate the amount of reflected light from a surface. It considers 3 things:
	1) Normal vector of the surface
	2) The vector to the viewer of the surface
	3) The vector to the lightsource
* Lighting in computer graphics is all about calculating the intensity and color of the light reaching the viewer. This involves computing the angles between the vectors above
* Lambert is a lighting model that defines the relationship between the brightness of a surface and its orientation to the light source. It is the simplest lighting model
  and it only considers one angle, that between the source and the normal of the surface.
  When the angle is very small, the source is close to being directly over the top of the surface ==> gives a maximum brightness
  When the angle is large, but less then 90 degrees ==> the surface is less bright
  When the angle is large, but greater then 90 degrees, the source is on the other side of the surface and therefore not affecting it
* Understanding the vectors involved in lighting models and writing your own shaders go hand in hand as it is the programmatic modification of these that allows to create many
  special effects
  
  
-------------------------------- Normal Mapping --------------------------------
* Modify the normal vector of the surface to generate a raised texture on a flat surface
* The Lambert lighting model is going to give a flat looking surface with the same brightness over the entire surface. What if you could determine a whole bunch of normals across
  the surface and then manipulate them?
* Normal Map
	- One thing normals are used for is determining brightness. This brightness in the Lambert lighting model is determined by the angle between the normal and the light source.
	  The more a normal faces the viewer, the stronger the brightness at that point on the surface.
	- They usually have a length of 1 when used in many mathematical computations
	- Used for manipulating the normals used for the lighting calculations
	- Instead of having one normal on a flat surface, a normal map produces one for each pixel but it doesnt just make more normals - it changes their direction as well
	- When the brightness is calculated using the position of the light source, each normal is going to give a different brightness value
	- These normals are only for visual effects, they do not modify the geometry of the mesh
	- Each pixel in a normal map is stored as an RGB color value
		* The values for each channel that range from 0-255 are mapped into X,Y and Z values
		* Reds between 0-255 become an X-value between -1 and 1
		* Green is mapped the same for Y
		* Blue is only mapped between 128-255 to a Z-value between 0 and -1, using only mid to high blue channel values. That is what gives the texture its blue tinge.
	- For each pixel of the normal map, the RGBA channels are converted into X,Y,Z values that represent a vector. This vector becomes a normal at that pixel location.
	  X and Y values lie vertical and horizontal across the screen, with the positive Z-axis going into the screen.
	  That makes any normal on the side of the image facing the viewer (which should be coming out of the screen) have a negative Z-value
	Examples:
		1) A pixel with value (97,100,248) becomes the vector (-0.2, -0.2, -0.9)
		2) A light pink pixel value (196,129,235) will become the vector (0.5, 0, -0.9)
		3) A pixel with more yellow value (213,198,150) gives a normal of (0.6, 0.5, -0.6)
		NOTE: The less blue in a pixel, the flatter the normal. This means that fully blue areas represent bright areas (areas facing towards the viewer)
		      others away making them duller and giving them the illusion of shadows
	- BUMP MAPPING
		* Produces great depth results on the the cheap, but it is limited as it only creates visual effects and not a geometric one
		* Perfect way to get detail and depth into a model for a very little cost to processing
		* It relies on where the source and the direction of the light it
		* Normal mapping is a version of bump mapping
	- All above allows to add visual bumps to the surface of a model, where none exist geometrically
	- To increase the intensity of the normal map, calculations on the vectors that are being generated are needed
		* The Z axis of the surface vector represents brightness, not depth
		* The bright areas should stay bright, while the dark areas should be more darker. To do this, you can play around with the X and Y values of the vector. The Z shouldnt be
		  modified at all
	- If you change the Z value you will undoubtedly change the length as the normal starts to lean over. This will change the ANGLE. The only time you WONT change the angle 
	  is when Nx, Ny and Nz are changed equally and in this case the brightness doesn't change because the angle hasn't changed
	  
	NOTE: Remember when using a shader, YOU become the viewer and the Z axis is coming out of the computer screen at YOU.  Not the viewer game object shown in the scene
	NOTE: If you manipulate the Nz of the shader to the extreme you'll see the side of the sphere get brighter. 
	      This is because you have bent the normals around to be facing more toward and away from you.
		  If you make Nz negative, the normals will start to turn away from you and you'll see the brightness diminishing.
	
* Diffuse map
	- Color the albedo of an object. It simply provides a color to put on the mesh and nothing more
	- Lambert lighting treats it as flat, and lights it evenly across the surface
	

-------------------------------- Illumination Models --------------------------------
* worldRefl
	- World reflection
	- A vector stored in the model indicating which parts of a cube map should be mapped to which parts of the model
	- The world reflection vector is used to pick the parts of a cubemap, to map to the models emission output
	
* Normal vector
	- The vectors are constantly recalculated for the points on the model as the model turns, because their values are determined by how the model appears in screen space
	- If you compare the normals with the world reflection vectors, you will see that the normals are blended across the surface, giving a smooth appearance, whereas the others
	  have much harder divisions
	  The normals across the surface of each polygon are being calculated on a per-pixel basis, rather then using the geometric normals at each vertex
	- How the normal data from a model is dealt with depends on the illumination models:
		1) Flat - the simplest and least computationally heavy as it uses a single normal (usually the one that comes with the mesh) to shade each polygon.
				  That gives the entire surface of a polygon the same color and makes it appear flat.
		2) Gouraud - the color of pixels across the surface of a polygon are determined through interpolation of the colors at each vertex. This results in a blended shading effect
					 across each polygon. 
					 This shading works OK, until you add highly localized light. If a light is focused on a single polygon, its values are not transferred to neighboring polygons.
		3) Phong - the flat surface is made to appear curved by modifying the normals on a per-pixel basis across the polygon. Taking the actual normals at each vertex, the ones
				   across the surface are calculated as an interpolation of one to another. This results in a blended shading across each polygon.
				   This shading model is used today to provide a much smoother appearance and used in Unity by default
				   
* Shaders are a complex soup of geometry, color and lighting


-------------------------------- Buffers And Queues --------------------------------
* A pixel makes its ultimate journey from a point on a surface of a mesh to a point on the screen via the shader and into the frame buffer.
* Frame Buffer: a computer memory structure that holds the color information about every pixel that appears on the screen. The color has been calculated a variety of ways to includes
				geometry, textures, lighting and other computations
				
* Depth/Z Buffer: has the same dimensions as the frame buffer, but holds depth information for each pixel. 
				  As each pixel is added to the frame buffer, its depth is recorded in the Z buffer. However, before a pixel is added to the frame buffer, it is first tested to see 
				  if there is a corresponding value already in the Z buffer. If there is, it means that the same pixel in the frame buffer has already been given a value.
				  If the pixel trying to be added has a smaller depth value than the one already in the Z buffer, it means that it must be closer to the camera and therefore its color
				  should replace the one already in the frame buffer and then its depth is added to the Z buffer.
				  This way, only pixels closest to the camera end up getting rendered.
				  
* Unity generally renders a scene front-to-back. This means furthest things away from the camera are drawn last. The closest object's pixels are added to the frame buffer first, as well
  its depth information which is added to the Z buffer. Then the pixels of the furthest object are checked. If there is already a depth value in the Z buffer, then the new pixel 
  information is ignored.
  This helps to reduce the need to write pixels into the frame buffer twice. Anything behind something is simply ignored.
  In the shader code, you can turn the Z buffer writing off by including the line - ZWrite Off
  
* Render Queues
	- Control the draw ordering of objects
	- The rendering queues are, in order:
		1) Background
		2) Geometry -> used by default in shaders until now
		3) AlphaTest
		4) Transparent
		5) Overlay
	- The queues can be used in the shaders to force when objects are drawn. This setting can be found in the inspector
	- There is an option to specify the queue to use inside the shader code using the tag "Queue" -> Tags {"Queue" = "Geometry"}. You can also add custom values, for example adding
	  a value to the existing geometry queue would make objects with your shader draw AFTER other geometry objects, and depending on information in the Z buffer, that could bring your
	  object to the front
	- G buffer: geometry buffer which is used in deferred rendering, one of two techniques used to order the rendering pipeline operations around the shader. The other is 
	            forward rendering, where the object goes from Geometry => Vertex Shader => Geometry Shader before landing in the frame buffer.
				In deferred rendering, the geometry gets processed the same way with the exception of lighting. All the information about the geometry (albedo, depth, normal and 
				specular highlights) are stored in the G-buffer. The lighting is then the final step before the pixels land in the frame buffer
	- The difference between the forward and deferred rendering comes when rendering many objects
		* In forward rendering, each objects follows its own render path, which includes a lighting calculation. That is, for each object - all lights in the environment need to be
		  calcaulted. The more lights, the more calculations.
		* In deferred rendering, the lighting is only done on the G-buffer after the scene objects have been collated, therefore lighting calculations only happen once per light.
		
		NOTE: the deferred rendering is the preferred way to do things if you have many lights
		NOTE: the deferred rendering cannot display transparent objects correctly by default, because they are see-through objects and they need to display any lighting effects behind them,
		      and because lights are calculated at the end, they can't.
			  
		* You can change the rendering path pipeline in the graphics settings
				
				
#######################################################################################
################################## Dot Product ########################################
#######################################################################################
* The dot product of two vectors (A & B) is written a.b, and can be calculated in two ways
	1) Multiply the length of each vector together with the cosine of the angle between them
	2) Multiply each individual coordinate of one vector with the other and then adds them all together 
	
* In CG, the dot product can be calculated with the dot function => half dotp = dot(IN.viewDir, o.Normal); <=
	- Given two vectors, such as the viewing direction and the surface normal, a dot product can be calculated
	
* Why use that?
	- With normal maps, you can color pixels differently on certain parts of an object. With the dot product, you can process a surface based on where you were looking at it from
	- The dot product can produce effects such as rim lighting, outlining and anisotropic highlights
	- The dot product can tell us if two vectors are:
		1) Pointing in the same direction
		2) Pointing in opposite directions
		3) At 90 degrees
		4) Somewhere in between
	- When two vectors are normalized to their unit length of 1, the dot product for parallel vectors equates to 1. When they face opposite directions, the dot product is -1, and
	  when they are at right angles, the dot product is 0
	- If one of those vectors represents the normal on a polygon, then you can also deduce the side of the polygon the other vector is on:
		1) For a positive dot product, the vector is on the same side
		2) For a negative dot product, the vector is on the underside
		3) For a dot product of 0, it is lying on the surface
	- With the dot product results you can build custom shaders based on the direction of the viewer relative to an object. The viewer is always perceiving the virtual environment 
	  from their position behind the computer screen, and hence thats where the viewer direction comes from
	- Given the view direction and all the normals on the model, you can use a dot product to determine which sides of the mesh are facing toward the viewer and those that are facing
	  away. You can also tell how MUCH they are facing the viewer
		* Any normals that make a dot product with the view vector close to 1, will represent faces of the model that face (or sit quite perpendicular) to the viewer
		* Any normal close to zero will belong to the faces that are around the edges of the model
		* Any normal less then 1 will be on the other side of a polygon that the viewer can not see
		
		
-------------------------------- Rim Lighting --------------------------------
* Rim lighting/Shading is coloring around the edges of a model respective to the viewers location




#######################################################################################
#################################### Lighting #########################################
#######################################################################################
-------------------------------- Lighting Models --------------------------------
* Lambert
	- gives us diffuse lighting. It is a simple model and quite fast rendering which uses only the surface normal and the source vector in its calculation
	- Not very good at generating reflections and highlights (from light sources)
	
* Phong
	- Considers the viewers location, as well as how light reflects from a surface
	- It includes the calculation of specular reflection or how light bounces off a surface
	- A reflection will be at its strongest when the outgoing angle is equal to the incoming angle. On either side of the outgoing angle, the reflection is said to fall-off.
	  How much it falls off depends on the quality of the surface, where shinier objects have a quicker fall off.
	- The amount of reflection the viewer sees will depend on the angle between the reflection vector and the vector to the viewer
	- With a slow fall-off, the reflection loses strength gradually away from the reflection vector and spreads the shine out across the surface. A faster fall-off causes the shine
	  to diminish rapidly, out from the reflection vector and makes the object appear far glossier
* Blinn/Phong 
	- This model is an improvement on Phong, as it reduces the need to calculate the reflection vector (which requires a cosine operation)
	- It is a far more efficient specular reflection model then Phong alone
	- Introduce an additional vector to the Phong which is called the HALFWAY vector
	- This vector sits halfway between the source and the viewer
	- The equation for HALFWAY vector => h(halfway) = s(source) + v(viewer)
	- The angle between the normal and the halfway is then used to work out the intensity
	
* PBR (Physically Based Rendering)
	- Focuses on seven areas:
		1) Reflection - drawing rays from the viewer to the reflective surface and then calculating where it bounces off. It is a reverse calculation to lighting
		2) Diffusion - examines how color and light are distributed across the surface by considering what light is absorbed and what is reflected and how
		3) Translucency and Transparency - examines how light can move through objects and render them fully or partly see-through
		4) Conservation of energy - ensures objects never reflect more light then they receive, unless that object is a perfect mirror finish. Then, it wil absorb light depending
									on the surface. However, some lights will always be reflected and available to light other objects
		5) Metallicity - considers the interaction of light on shiny surfaces and the highlights and colors that are reflected. Metals tend to be highly reflective, with very little
						 in the way of diffuse light
		6) Fresnel reflectivity - examines how reflections on a curved surface become stronger towards the edges. The fresnel reflection is how real-world reflection works on a 
							      curved surface, with the reflections being much stronger on the edges and fading towards the center.
								  This effect will vary as the different surface types change. However, you will never get the perfect straight line of the horizon in a curved
								  surface as you do with the normal reflection
		7) Microsurface scattering - suggets that most surfaces are going to contain grooves or cracks that will reflect the light at different angles other then those dicatated
									 by a regular surface
									 
	- Unity includes two physically based shaders:
		1) The standard
		2) The standard specular
		
		The difference are similar to those between lambert and blinnPhong. 
		However, each of these PBR shaders has its own output structure. The only difference is:
			* The standard PBR system works with a metallic value, and the standard specular PBR works with the specular value
			* Instead of gloss and to facilitate microsurface scattering, both have a smoothness setting
			
	- The metallic texture will define which parts of the model will be shiny and which ones are dont. 
	  This map should be a greyscale image, so that all channels values will be the same. Then, you can paint on the image with black color to indicate that this areas
	  should not be shiny. When you get black, the channel value going through to smoothness will be 0.
	  So, 0 smoothness will occur on black areas on the map, and full smoothness will occur on white areas on the map
	  
	  NOTE: when adding emission level on the metallic map, it is enough to adjust only one channel
	  
	- Specular
		* The specular itself is a fixed3 value, so it is going to take an RGB value. It is the color of the specular lighting or the specular highlights
		
	- Matallic VS Specular
		* Metallic tends to be the surface and affects what is going on on the surface and the quality of the surface
		* Specular is the light being reflected from an object
									 
* Vertex VS Pixel lighting
	- Vertex lighting is Gouraud shading in reverse, where the incoming light is calculated at each vertex and then averaged across the surface
	- Pixel lighting is a phong-like, where a light for each pixel is calculated
	- Pixel lighting benefits over vertex lighting, as Phong shading benefis over Gouraud
	- Pixel lit will pick up far more detailed specular highlights then vertex, as the light is calcualted for every point. It provides far more detailed shading, but requires more
	  processing. Vertex lit suits for older graphic cards or mobile devices, or maybe when there are many things to render where the quality doesnt really matter so much
	  
	  
##################################################################################################
#################################### PASSES AND BLENDING #########################################
##################################################################################################
--------------------------------------- Alpha Channel ---------------------------------------
* It is the 4th pixel value after the RGB in the color
* It represents how transparent that particular pixel is. This transparency is used when compositing with several images
* The alpha channel allows to make objects transparent and see through
* It is used to mask sections of an image off, so that only parts of that image are visible
* It is useful in games for creating billboards that have simple geometry and can be used on maps
* Transparency objects do not write to the Z buffer, so they always end up at the end of the pipeline and they should happen after everything else
https://docs.unity3d.com/Manual/HOWTO-alphamaps.html
	  
	
