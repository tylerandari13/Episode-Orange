extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	owner.velocity.y += owner.gravity * delta

	if(Input.is_action_pressed("left") && owner.velocity.x > owner.speed * -1):
		owner.velocity.x -= 25
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.speed):
		owner.velocity.x += 25

	if(owner.is_on_floor()):
		if(owner.get_floor_angle() == 0):
			owner.velocity = Vector2()
			change_state("Landing")
		else:
			owner.direction = -1 if owner.get_real_velocity().x < 1 else 1
			owner.mach = min(owner.velocity.abs().y, owner.mach3)
			change_state("MachRun")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

