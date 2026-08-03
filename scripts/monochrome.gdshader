//////////////////// SHADER MADE BY AI ////////////////////

shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // 1. Grab the current transparency/alpha of the ColorRect
    float rect_alpha = COLOR.a;
    
    // 2. Fetch the screen behind the rect
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
    
    // 3. Calculate grayscale
    float gray = dot(screen_color.rgb, vec3(0.299, 0.587, 0.114));
    
    // 4. Mix between original screen color and gray using rect_alpha
    vec3 final_rgb = mix(screen_color.rgb, vec3(gray), rect_alpha);
    
    // 5. Output the result (keep alpha at 1.0 so the screen stays solid)
    COLOR = vec4(final_rgb, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
