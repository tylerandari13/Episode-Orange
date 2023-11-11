extends "res://scripts/OrangeState.gd"

var has = false # this is ridiculous

# Called when the state machine enters this state.
func on_enter():
	owner.mach = owner.grab_speed
	owner.direction = owner.direction * -1
	owner.velocity = Vector2(owner.grab_speed * owner.direction, owner.jump_velocity)

func on_physics_process(delta):
	if(owner.is_on_floor()):
		if(Input.is_action_pressed("run")):
			change_state("MachRun")
		else:
			change_state("Ground")
	if(owner.is_on_wall() && owner.get_wall_normal().x != owner.direction):
		change_state("Wallrun")

func on_input(event : InputEvent):
	if(event.is_action_pressed("grab")):
		change_state("Grab")

func on_exit():
	has = false