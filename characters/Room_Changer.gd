extends PlayerTrigger

@export var room_name : String
@export var room_spawnpoint : String

func collision_entered(player : CharacterBody2D):
	player.change_room(room_name, room_spawnpoint)

func collision_exited(_player : CharacterBody2D):
	pass

func collision_process(_player : CharacterBody2D, _delta : float):
	pass
