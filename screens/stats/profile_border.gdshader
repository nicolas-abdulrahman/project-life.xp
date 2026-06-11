shader_type canvas_item;

// This allows you to pass your black/white mask texture directly into the shader
uniform sampler2D mask_texture : filter_nearest;
uniform vec4 color : source_color;
void fragment() {
    // Get the color of the current UI element/child texture
    vec4 current_color = texture(TEXTURE, UV);
    
    // Sample the color of your black and white mask at the exact same UV coordinate
    vec4 mask_color = texture(mask_texture, UV);
    if (mask_color.a == 0.0){
		discard;
	}
    // Calculate the luminance (brightness) of the mask pixel
    // Pure white = 1.0, Pure black = 0.0
    float luminance = (mask_color.r + mask_color.g + mask_color.b) / 3.0;
    
    // Smoothly step or sharply clip. If the mask pixel is white (luminance > 0.5), 
    // we keep the child's color. If it's black, we make it transparent (alpha = 0.0)
    // so the black background shows through.
    if (luminance < 0.5) {
        // Drop the child pixel lipipi completely where the mask is black
   		COLOR = color;
    } else {
		
        COLOR = current_color;
    	
	}
}