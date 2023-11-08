extends "res://scripts/OrangeState.gd"


# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if((owner.direction > 0 && owner.velocity.x < 0) || (owner.direction < 0 && owner.velocity.x > 0)):
		owner.velocity.x += 20 * owner.direction
	else:
		if(owner.is_on_floor()):
			change_state("MachRun")
		else:
			owner.velocity.x = 0
	


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

