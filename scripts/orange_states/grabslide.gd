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
	if(owner.is_on_wall()):
		owner.velocity = Vector2(70 * owner.direction * -1 * owner.get_mach(), owner.get_mach(true) * -0.3)
		change_state("DuckJump")

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

