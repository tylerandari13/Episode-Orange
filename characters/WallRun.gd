extends State

class_name WallRunState

@export var air_state : State

var speed : float = 0
var speed_overriode : bool = false

var direction : float = 0

func state_input(_event : InputEvent):
	pass

func state_process(_delta):
	if(character.is_on_wall()):
		character.velocity.x = 0
		character.velocity.y = speed * -1
		speed += character.acceleration
	else:
		next_state = air_state

func on_enter():
	if(speed_overriode):
		speed_overriode = false
	else:
		speed = 0

func on_exit():
	pass

func override_speed(_speed : float):
	speed_overriode = true
	speed = _speed
