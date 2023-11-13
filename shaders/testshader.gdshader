shader_type canvas_item;

void fragment(){
	if(COLOR.rgb == vec3(0.0, 0.0, 0.0)) {
		COLOR = vec4(1.0, 0.0, 0.0, COLOR.a);
	} else {
		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	}
}
