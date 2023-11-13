extends PlayerTrigger

func collision_entered(player : CharacterBody2D):
	player.change_room(room_name, room_spawnpoint)
