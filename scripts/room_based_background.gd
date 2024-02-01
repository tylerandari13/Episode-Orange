extends ParallaxLayer

@export_category("Room Based Parallax")
@export var room_name = ["main"]

# Called when the node enters the scene tree for the first time.
func _ready():
	owner.add_background(room_name, self)
