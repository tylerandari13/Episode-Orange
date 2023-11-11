extends Area2D

class_name Trigger

@export var collision_shape : CollisionShape2D
@export var collidor_object : Node = Node.new()

var has_called : bool = false

func _process(delta):
	if(overlaps_body(collidor_object)):
		if(!has_called):
			has_called = true
			collision()
		collision_process(delta)
	else:
		has_called = false

func collision():
	pass

func collision_process(_delta):
	pass
