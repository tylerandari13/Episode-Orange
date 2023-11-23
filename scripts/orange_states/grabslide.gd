extends "res://scripts/OrangeState.gd"

# Called when the state machine enters this state.
func on_enter():
	owner.set_ducking(true)
	owner.mach = owner.mach3


# Called every frame when this state is active.
func on_process(delta):
	owner.velocity.x += 250 * delta * owner.direction
	if(owner.velocity.abs().x >= owner.mach3):
		change_state("MachRun")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	owner.set_ducking(false)

