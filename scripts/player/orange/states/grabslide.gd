extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	pass

# Global.apply_delta_time()
# Called every frame when this state is active.
func on_process(delta):
	if(abs(owner.velocity.x) >= owner.mach3):
		if(owner.can_unduck() && !Input.is_action_pressed("down")):
			owner.mach_speed = owner.mach3
			change_state("none/machrun")
	else:
		owner.velocity.x += Global.apply_delta_time(owner.acceleration, delta) * owner.direction


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

