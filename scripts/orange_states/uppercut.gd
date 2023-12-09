extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity * 1.5 if owner.is_on_floor() else owner.jump_velocity


# Called every frame when this state is active.
func on_process(delta):
	pass

# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.is_action_pressed("left") && owner.velocity.x > owner.speed * -1):
		owner.velocity.x -= 2300 * delta
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.speed):
		owner.velocity.x += 2300 * delta

	if(owner.is_on_floor()):
		change_state("Ground")

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

