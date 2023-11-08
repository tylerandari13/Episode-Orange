extends "res://scripts/OrangeState.gd"


# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity * -1
	owner.set_ducking(true)


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(owner.is_on_floor()):
		if(Input.is_action_pressed("down")):
			change_state("Roll")
		else:
			change_state("MachRun")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	owner.set_ducking(false)

