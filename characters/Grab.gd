extends State

class_name GrabState

@export var mach_state : State
@export var ground_state : State

var dir : float = 1

var grab_time = 0.7
var cur_time = 0

var grab_velocity : float = 0

func state_input(_event : InputEvent):
	pass

func state_process(delta):
	if(cur_time < grab_time):
		cur_time += delta
	else:
		character.velocity.x = 0
		character.animated_sprite.play("default")
		if(Input.is_action_pressed("run")):
			mach_state.override_speed(grab_velocity)
			next_state = mach_state
		else:
			next_state = ground_state

func on_enter():
	cur_time = 0
	grab_velocity = (mach_state.mach3 if character.velocity.abs().x <= mach_state.mach3 else character.velocity.abs().x)
	character.velocity.x = grab_velocity * dir
	character.animated_sprite.play("grab")

func on_exit():
	pass
