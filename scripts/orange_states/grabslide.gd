extends "res://scripts/OrangeState.gd"

# Called when the state machine enters this state.
func on_enter():
	owner.mach = owner.mach3


# Called every frame when this state is active.
func on_process(delta):
	if(owner.velocity.abs().x >= owner.mach3 + owner.speed):
		if(!Input.is_action_pressed("down") && owner.can_stand()):
			change_state("MachRun")
	else:
		owner.velocity.x += 750 * delta * owner.direction


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

