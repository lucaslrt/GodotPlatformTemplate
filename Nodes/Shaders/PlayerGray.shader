shader_type canvas_item;
render_mode unshaded;

void fragment() {
	COLOR = texture(TEXTURE, UV);
//	float lumi = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	float lumi = (COLOR.r * 0.2126 + COLOR.g * 0.7152 + COLOR.b * 0.0722);
	COLOR.rgb = vec3(lumi);
}