Shader "EranM/BlendTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {} // The "black" refers to the color that you get in your scene, IF you leave the 
                                              // texture out
                                              // BLACK => full transparency
                                              // WHITE => full opaque
    }
    SubShader
    {
       Tags {"Queue" = "Transparent"}
       // The blend command takes on a couple of formats
       // You can use the keyword 'blend' followed by a value that is to be multiplied with the incoming color
       // and a value that is to be multiplied with the current color => 
       // Blend SrcFactor(Incoming Color) DestFactor(Current Color)

       // These blands are used in the particle systems as well for putting the particles on the screen
       // Use the Shader => Particles => Blend option to understand how each blend works


       //Blend One One // Multiplies one by the incoming color and then it multiplies what is already in the frame buffer by the
                     // incoming color, and then it adds them together
                     // One => use this to let either the source or the destination color come through fully
                     // Anything on the image that is black is going to disappear, because its going to be added in and blacks 0,
                     // so it is just going to disappear in the color effect.

                     // Takes the color that is on the texture, and multiplying it by 1, while also getting the color already
                     // in the frame buffer (whatever is behind the object) which multiplies it by 1
                     // Each color stays what it basically is, but then it ADDS them together
                     // When it comes together, you end up seeing the influence of both colors come through into the object
    
       //Blend SrcAlpha OneMinusSrcAlpha // Multiply the incoming value by the source alpha
                                       // Whatever the alpha of the source image is, its going to use that and the color that is
                                       // already in the frame buffer is going to be multiplied by (1-currentAlpha)
                                       // In a way, it is switching the alpha around
                                       // This is the traditional blend that happens for transparency
                                       // Use this when working with existing shaders for something that is transparent

        Blend DstColor Zero // Multiply the incoming color by the destination color
                            // This is the ecolor that is already in the frame buffer
                            // It will multiply that up and then the frame buffer color will be multiplied by 0
                            // The current color in the frame buffer is basically being discarded, because it just multiplying
                            // it with the incoming color
                            // This is a soft additive blend
                            // When using a black and white image, the black areas will stay black, and the white areas will be
                            // fully transparent
                            // Wherever its black, its a value of 0 which will multiply it with the background, which would give us 
                            // 0 or black. We actually get black, and then we get whatevers underneath showing through

       Pass 
       {
            SetTexture [_MainTex] {combine texture} // Replacing the pixels in the frame buffer with whatever is in our texture            
       }
    }
}
