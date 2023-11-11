class_name PlayerTrigger
extends Area2D

var has_called : bool = false

@export var room_name : String
@export var room_spawnpoint : String

func _process(delta):
	for body in get_overlapping_bodies():
		if("is_player" in body):
			collision_process(body, delta)

func _on_body_entered(body):
	if("is_player" in body):
		collision_entered(body)

func _on_body_exited(body):
	if("is_player" in body):
		collision_exited(body)


func collision_entered(player : CharacterBody2D):
	player.change_room(room_name, room_spawnpoint)

func collision_exited(_player : CharacterBody2D):
	pass

func collision_process(_player : CharacterBody2D, _delta : float):
	pass
