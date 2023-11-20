class_name collectible
extends PlayerTrigger

var respawns = false
var alpha = modulate.a
var collected = false

func collision_entered(player : CharacterBody2D):
	modulate.a = alpha * 0.5 if player.get_current_room().is_secret else 0
	collect(player)

func respawn():
	modulate.a = alpha
	collected = false

func collect(player : CharacterBody2D):
	collected = true
