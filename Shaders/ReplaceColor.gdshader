shader_type canvas_item;

uniform vec4 orig_color : source_color = vec4(1.0);
uniform vec4 replace_color : source_color = vec4(1.0);

uniform bool activated = false;

void fragment() {
	if (activated && COLOR == orig_color) {
		COLOR = replace_color;
	}
}
