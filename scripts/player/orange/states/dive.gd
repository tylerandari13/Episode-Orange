extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	owner.sprite.play("dive")
	owner.velocity.y = owner.jump_velocity * -1


# Called every frame when this state is active.
func on_process(delta):
	if(owner.is_on_floor()):
		if(Input.is_action_pressed("down")):
			change_state("none/roll")
		else:
			change_state("none/machrun")
	if(Input.is_action_just_pressed("jump")):
		owner.sprite.play("divebomb")
		change_state("none/bodyslam")
	if(owner.is_on_wall()):
		owner.sprite.play("bonk")
		change_state("none/bonk")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

