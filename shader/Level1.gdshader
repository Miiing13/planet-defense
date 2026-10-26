shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(0.4, 0.5, 0.8, 1.0);
uniform float intensity : hint_range(0.0, 1.0) = 0.15;
uniform float speed : hint_range(0.0, 2.0) = 0.2;

void fragment() {
	vec2 uv = UV;
	float t = TIME * speed;

	float wave1 = sin(uv.x * 6.0 + t);
	float wave2 = cos(uv.y * 5.0 - t * 0.7);
	float wave3 = sin((uv.x + uv.y) * 4.0 + t * 0.5);

	float light = (wave1 + wave2 + wave3) / 3.0;
	light = smoothstep(-0.8, 0.8, light);

	float alpha = light * intensity;

	COLOR = vec4(light_color.rgb, alpha);
}