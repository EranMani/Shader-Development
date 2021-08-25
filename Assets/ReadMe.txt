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