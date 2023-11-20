class_name Room
extends Area2D
@export_group("room_info")
@export var collision_object : CollisionShape2D
@export var is_secret : bool
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

func get_collision():
	if(collision_object):
		return collision_object
	else:
		for child in get_children():
			if(child is CollisionShape2D):
				return child
	return CollisionShape2D.new()

func get_rect():
	var retrect = get_collision().shape.get_rect()
	retrect.position.x += get_collision().position.x
	retrect.position.y += get_collision().position.y
	return retrect

func get_spawnpoint(spawn : String):
	if(get_node(spawn) is Node2D):
		return get_node(spawn)
	return Node2D.new()
