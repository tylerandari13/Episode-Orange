extends Node2D

@export var velocity : Vector2

func _process(delta):
	position += Global.apply_delta_time(velocity, delta)
