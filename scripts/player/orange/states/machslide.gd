extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	owner.mach_speed = 0
	change_state("none/ground")


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

