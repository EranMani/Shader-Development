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