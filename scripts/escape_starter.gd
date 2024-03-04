class_name EscapeStarter
extends Area2D

@export var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_body_entered)

func _body_entered(body : Node2D):
	if(body is Player):
		owner.start_escape(time)
		collision_mask = 0
