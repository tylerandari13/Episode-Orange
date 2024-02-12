extends NodeOrange

var hue_shaders = {}
var hue_shader_placeholder = preload("res://shader/hue_shift.gdshader")

# do not change the 60 lmao
func apply_delta_time(start, delta): return (start * delta) * 60

func hue_shader(hue):
	if(!(hue in hue_shaders)):
		var new_shader = ShaderMaterial.new()
		new_shader.shader = hue_shader_placeholder.duplicate(true)
		new_shader.set_shader_parameter("Shift_Hue", hue)
		hue_shaders[hue] = new_shader
	return hue_shaders[hue]
