extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.is_action_pressed("run")):
		if((owner.direction == -1 && Input.is_action_pressed("left"))
		|| (owner.direction == 1 && Input.is_action_pressed("right"))
		|| owner.mach < owner.mach3):
			if(owner.is_on_floor()):
				if(owner.mach < owner.mach3):
					owner.mach += 10
				elif(owner.mach < owner.machtop):
					owner.mach += 1

		owner.velocity.x = owner.direction * (owner.speed + owner.mach)

		if((owner.direction == 1 && Input.is_action_pressed("left"))
		|| (owner.direction == -1 && Input.is_action_pressed("right"))):
			owner.direction = owner.direction * -1
			change_state("MachDrift")
	else:
		change_state("MachSlide")
	if(owner.is_on_wall()):
		if(owner.is_on_floor()):
			if(owner.get_floor_angle() == 0):
				owner.velocity = Vector2(70 * owner.direction * -1 * owner.get_mach(), owner.get_mach(true) * -0.3)
				change_state("Landing")
			else:
				change_state("Wallrun")
		else:
			change_state("Wallrun")
	if(Input.is_action_pressed("up") && owner.get_mach() >= 3 && owner.is_on_floor()):
		change_state("SuperJump")
	if(Input.is_action_pressed("down")):
		if(owner.is_on_floor()):
			change_state("Roll")
		else:
			change_state("Dive")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("jump") && owner.is_on_floor()):
		owner.velocity.y = owner.jump_velocity


# Called when the state machine exits this state.
func on_exit():
	pass

