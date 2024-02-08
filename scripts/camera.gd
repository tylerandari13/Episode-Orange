class_name PlayerCamera
extends Camera2D

var current_shake = 0

func _process(delta):
	position = owner.velocity * 0.2
