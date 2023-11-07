extends State

class_name WallRunState

@export var air_state : State
@export var long_state : State
@export var mach_state : State

var speed_overriode : bool = false

var jump_speed : float = 0
var jump_speed_overriode : bool = false

var roof_time : float = 0.2

var direction : float = 0
var cur_time : float = 0

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		character.velocity.x = jump_speed
		next_state = long_state

func state_process(delta):
	if(Input.is_action_pressed("run")):
		if(character.is_on_wall()):
			character.velocity.x = direction
			character.velocity.y = character.mach * -1
			character.mach += character.acceleration
		else:
			character.velocity.y = 0
			mach_state.override_speed(character.mach)
			next_state = mach_state
	else:
		character.velocity.y = -100
		next_state = air_state

	if(character.is_on_ceiling()):
		cur_time += delta
		if(cur_time >= roof_time):
			next_state = air_state

func on_enter():
	if(speed_overriode):
		speed_overriode = false
	else:
		character.mach = 0
	if(jump_speed_overriode):
		jump_speed_overriode = false
	else:
		jump_speed = mach_state.mach2 * direction * -1

func on_exit():
	cur_time = 0

func override_speed(_speed : float):
	speed_overriode = true
	character.mach = _speed

func override_jump_speed(_speed : float):
	jump_speed_overriode = true
	jump_speed = _speed
