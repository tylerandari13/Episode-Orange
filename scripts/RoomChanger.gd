class_name RoomSwitcher
extends PlayerTrigger

@export var room_name : String = "main"
@export var room_spawnpoint : String = "main"

func collision_entered(player : CharacterBody2D):
	player.change_room(room_name, room_spawnpoint)
