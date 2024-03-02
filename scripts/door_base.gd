class_name DoorBase
extends Area2D

func _process(delta):
	for body in get_overlapping_bodies():
		if(body is Player && body.is_on_floor() && Input.is_action_just_pressed("up")):
			_entered(body)

func _entered(player : Player): pass
