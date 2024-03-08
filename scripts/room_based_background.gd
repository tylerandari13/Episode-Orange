extends ParallaxLayer

@export_category("Room Based Parallax")
@export var room_name : Array[String] = ["main"]
@export var speed : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	owner.add_background(room_name, self)

func _process(delta):
	if(visible):
		motion_offset += Global.apply_delta_time(delta, speed)
