extends PlayerState


# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity * 1.5


# Called every frame when this state is active.
func on_process(delta):
	if(owner.is_on_floor()): change_state("none/ground")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

