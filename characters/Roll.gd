extends State

class_name RollState

@export var mach_state : State
@export var dive_state : State

var speed : float = 0
var speed_override : bool = false

func state_process(_delta):
	if(!Input.is_action_pressed("down")):
		mach_state.override_speed(speed)
		next_state = mach_state
	if(!character.is_on_floor()):
		dive_state.override_speed(speed)
		next_state = dive_state

func on_enter():
	if(speed_override):
		speed_override = false 
	else:
		speed = mach_state.mach1
	character.set_ducking(true)

func on_exit():
	character.set_ducking(false)

func override_speed(_speed : float):
	speed = _speed
	speed_override = true
