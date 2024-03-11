extends NodeOrange

var storage = {}

var hue_shaders = {}
var hue_shader_placeholder = preload("res://shaders/hue_shift.gdshader")

var auto_spawn_player = true

# do not change the 60 lmao
func apply_delta_time(start, delta): return (start * 60) * delta

func load_level(level : String, position = null):
	#auto_spawn_player = auto_spawn
	set_storage("last-loaded-level", level)
	get_tree().change_scene_to_file(level)
	

func hue_shader(hue):
	hue = (int(hue * 10) % 10) * 0.1
	if(!(hue in hue_shaders)):
		if(hue == 0):
			return hue_shader_placeholder
		else:
			var new_shader = ShaderMaterial.new()
			new_shader.shader = hue_shader_placeholder.duplicate(true)
			new_shader.set_shader_parameter("Shift_Hue", hue)
			hue_shaders[hue] = new_shader
	return hue_shaders[hue]

func get_storage(key):
	return storage[key]
func set_storage(key, value):
	storage[key] = value

func get_level():
	return get_storage("level")
func set_level(level : Level):
	set_storage("level", level)

func average(numbers : Array): return numbers.reduce(func(accum, number): return accum + number, 0) / len(numbers)
