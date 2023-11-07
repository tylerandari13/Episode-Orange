extends State

class_name LongJumpState

@export var mach_state : State
@export var ground_state : State
@export var wall_state : State

var direction : float = 1

func state_process(_delta):
	if(character.is_on_floor() && character.velocity.y >= 0):
		if(Input.is_action_pressed("run")):
			mach_state.override_speed(character.mach)
		else:
			mach_state.override_speed(mach_state.mach2)
		next_state = mach_state

	if(character.is_on_wall()):
		wall_state.direction = direction
		wall_state.override_speed(mach_state.mach2)
		next_state = wall_state

func on_enter():
	direction = character.direction
	character.velocity.y = character.jump_velocity
