extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	pass

# Global.apply_delta_time()
# Called every frame when this state is active.
func on_process(delta):
	owner.velocity.x += Global.apply_delta_time(owner.acceleration, delta) * owner.direction
	if(abs(owner.velocity.x) >= owner.mach3):
		owner.mach_speed = owner.mach3
		change_state("none/machrun")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

