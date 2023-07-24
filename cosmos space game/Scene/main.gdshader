shader_type spatial;

uniform vec3 color;

void fragment() {
	// Place fragment code here.
	ALBEDO = color;	
}
