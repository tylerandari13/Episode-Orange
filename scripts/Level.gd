class_name Level
extends Node2D

@export var start_room : String
@export var start_spawn : String

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Globals.collectibles)

	if(Players.get_player("orange") == null):
		Players.spawn_player("orange")
	var player_holder = Players.get_player("orange")
	Players.enable_player("orange", true)
	if(!start_room.is_empty() || !start_spawn.is_empty()):
		player_holder.change_room("main" if start_room.is_empty() else start_room,
								"main" if start_spawn.is_empty() else start_spawn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
