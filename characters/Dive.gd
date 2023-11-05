extends State

class_name DiveState

@export var mach_state : State

var speed : float = 0
var speed_override : bool = false

func state_input(_event : InputEvent):
	pass

func state_process(_delta):
	if(character.is_on_floor()):
		mach_state.override_speed(speed)
		next_state = mach_state

func on_enter():
	if(speed_override):
		speed_override = false
	else:
		speed = mach_state.mach3
	character.velocity.y = character.jump_velocity * -1

func on_exit():
	pass

func override_speed(_speed : float):
	speed_override = true
	speed = _speed
