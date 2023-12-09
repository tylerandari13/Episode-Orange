extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity * -1


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(owner.is_on_floor()):
		if(Input.is_action_pressed("down")):
			change_state("Roll")
		else:
			change_state("MachRun")
	if(owner.is_on_wall()):
		change_state("WallRun")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		change_state("BodySlam")
		if(!(Input.is_action_pressed("left") || Input.is_action_pressed("right"))):
			owner.velocity.x = 0


# Called when the state machine exits this state.
func on_exit():
	pass

