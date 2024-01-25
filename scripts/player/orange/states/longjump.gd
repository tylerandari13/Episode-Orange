extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	owner.sprite.play("longjump")
	owner.set_mach_speed_to_velocity()


# Called every frame when this state is active.
func on_process(delta):
	if(owner.is_on_floor()):
		if(Input.is_action_pressed("run")):
			change_state("none/machrun")
		else:
			change_state("none/ground")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

