shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

uniform int one_in_times = 5;
uniform float scanline_opacity: hint_range(0.0, 1.0) = 0.1;

void fragment() {
	vec3 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	bool is_line = int(VERTEX.y)%one_in_times == 0;
	float line_color = float(!is_line);
	if (is_line) {
		color = mix(color,vec3(line_color, line_color, line_color), scanline_opacity);
	}
	COLOR = vec4(color, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
