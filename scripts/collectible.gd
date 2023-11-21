class_name CollectibleBase
extends PlayerTrigger

var alpha = modulate.a
var collected = false

func collision_entered(player : CharacterBody2D):
	if(!collected):
		modulate.a = alpha * 0.5 if player.get_current_room().is_secret else 0
		collected = true
		on_collected(player)

func respawn():
	if(collected):
		modulate.a = alpha
		collected = false
		on_respawn()

func on_respawn(): pass

func on_collected(player : CharacterBody2D): pass
