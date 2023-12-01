class_name Room
extends Area2D
@export_group("room_info")
@export var collision_object : CollisionShape2D
@export var is_secret : bool
@export_group("misc")
@export var is_room : bool = true

var spawn_points : Dictionary

func _ready():
	Globals.add_room(self)

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
	if(spawn in spawn_points):
		return spawn_points[spawn]
	else:
		return RoomSpawnPoint.new()

func add_spawn_point(spawn : Marker2D):
	spawn_points[spawn.name] = spawn
