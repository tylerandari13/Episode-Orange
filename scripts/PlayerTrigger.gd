class_name PlayerTrigger
extends Area2D

func _ready():
	body_entered.connect(self._on_body_entered)
	body_exited.connect(self._on_body_exited)

func _process(delta):
	for body in get_overlapping_bodies():
		if(body is Player):
			collision_process(body, delta)

func _on_body_entered(body):
	if(body is Player):
		collision_entered(body)

func _on_body_exited(body):
	if(body is Player):
		collision_exited(body)


func collision_entered(_player : CharacterBody2D): pass

func collision_exited(_player : CharacterBody2D): pass

func collision_process(_player : CharacterBody2D, _delta : float): pass
