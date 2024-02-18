extends NodeOrange

var hue_shaders = {}
var hue_shader_placeholder = preload("res://shaders/hue_shift.gdshader")

# do not change the 60 lmao
func apply_delta_time(start, delta): return (start * delta) * 60

func hue_shader(hue):
	hue = (int(hue * 10) % 10) * 0.1
	if(!(hue in hue_shaders)):
		if(hue != 0):
			var new_shader = ShaderMaterial.new()
			new_shader.shader = hue_shader_placeholder.duplicate(true)
			new_shader.set_shader_parameter("Shift_Hue", hue)
			hue_shaders[hue] = new_shader
		else:
			return hue_shader_placeholder
	return hue_shaders[hue]
