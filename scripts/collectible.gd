class_name collectible
extends PlayerTrigger

var respawns = false
var alpha = modulate.a

func collision_entered(player : CharacterBody2D):
	collect(player)

func respawn():
	visible = true
	modulate.a = alpha

func collect(player : CharacterBody2D):
	if(player.get_current_room().is_secret):
		modulate.a = 0.5
	visible = false
