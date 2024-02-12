class_name HueShift
extends NodeOrange

@export_range(0.0, 1.0) var shift = 0.0
@export var target : CanvasItem
@export_group("Randomization")
@export var random = false
@export var divide_by = 10

# Called when the node enters the scene tree for the first time.
func _ready(): set_hue()

func set_hue(hue = NAN):
	if(is_nan(hue)): hue = shift
	if(!is_instance_valid(target)): target = get_parent()
	if(target is CanvasItem):
		if(random):
			target.material = Global.hue_shader(randi_range(1, divide_by) / float(divide_by))
		else:
			target.material = Global.hue_shader(hue)
	else:
		push_warning("Node ", target, " is not a child of CanvasItem.")
