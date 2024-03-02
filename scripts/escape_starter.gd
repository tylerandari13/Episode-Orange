class_name EscapeStarter
extends Area2D

@export var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_body_entered)

func _body_entered(body : Node2D):
	if(body is Player):
		body.escape_sequence(time * 60 if time > 0 else -1)
		collision_mask = 0
