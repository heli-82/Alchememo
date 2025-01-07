shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform float ghost: hint_range(0.0, 10.0) = 3.0;
uniform float brightness: hint_range(0.0, 2.0) = 1.0; // When adding scanline gaps and grille the image can get very dark. Brightness tries to compensate for that.

void fragment()
{
	vec2 screen_uv = SCREEN_UV;
	vec3 color = texture(SCREEN_TEXTURE, screen_uv).rgb * (1.0 - brightness*0.5);
	color += texture(SCREEN_TEXTURE, screen_uv - vec2(SCREEN_PIXEL_SIZE.x * ghost, 0.0)).rgb;
	color += texture(SCREEN_TEXTURE, screen_uv * vec2(SCREEN_PIXEL_SIZE.x * ghost, 0.0)).rgb;
	color *= brightness*0.25;
	COLOR = vec4(color, 1.0);
}