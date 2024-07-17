shader_type spatial;

uniform float blend_amount:hint_range(-0.1, 1.0, 0.01) = 0.25;	// How much to blend the two textures together
uniform float tex1_resolution:hint_range(0.01, 10.0, 0.1) = 1.0;
uniform float tex2_resolution:hint_range(0.01, 10.0, 0.1) = 1.0;
uniform sampler2D texture1;										// The texture above
uniform sampler2D texture2;										// The texture below
uniform sampler2D depth_map;									// The depth-map matching texture1

void fragment() {
	float depth = texture(depth_map, UV * tex1_resolution).r;		// Get the depth of the pixel from the depth map
    vec4 tex1 = texture(texture1, UV * tex1_resolution);			// Get the first texture
    vec4 tex2 = texture(texture2, UV * tex2_resolution);			// Get the second texture	

	float blend = clamp((depth - blend_amount) * 10.0, 0.0, 1.0);	// Blend pixel based on depth map	
	vec4 blended_color = mix(tex2, tex1, blend);					// Blend the two textures with the blended pixel	
	ALBEDO = blended_color.rgb;										// Set the albedo	
}
