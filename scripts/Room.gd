class_name Room
extends Area2D
@export_group("room_info")
@export var collision_object : CollisionShape2D
@export_group("misc")
@export var is_room : bool = true

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_spawnpoint(spawn : String) -> Vector2:
	if(get_node(spawn) is Node2D):
		return get_node(spawn).position
	return Vector2(0, 0)
