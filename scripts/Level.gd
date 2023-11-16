extends Node2D

@export var start_room : String
@export var start_spawn : String
@export var player_spawner : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_holder = player_spawner.spawn_player("orange")
	if(!start_room.is_empty() || !start_spawn.is_empty()):
		player_holder.get_node("orange").change_room("main" if start_room.is_empty() else start_room,
													"main" if start_spawn.is_empty() else start_spawn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
