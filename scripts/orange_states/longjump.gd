extends "res://scripts/OrangeState.gd"


# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(owner.is_on_floor() && owner.velocity.y >= 0):
		change_state("MachRun")
	if(owner.is_on_wall()):
		change_state("Wallrun")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("down")):
		change_state("Dive")


# Called when the state machine exits this state.
func on_exit():
	pass

