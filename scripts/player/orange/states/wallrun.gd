extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.sprite.play("wallrun")


# Called every frame when this state is active.
func on_process(delta):
	if(Input.is_action_pressed("run")):
		owner.velocity.x = owner.direction
		if(owner.is_on_wall()):
			owner.velocity.y = owner.mach_speed * -1
			owner.mach_speed += Global.apply_delta_time(owner.acceleration, delta)
		elif(owner.direction != owner.get_wall_normal().x):
			owner.velocity.y = -10
			change_state("none/machrun")
	else:
		owner.velocity.y = -10
		change_state("none/air")

	if(Input.is_action_pressed("jump")):
		#owner.direction = owner.direction * -1
		owner.direction = owner.get_wall_normal().x
		owner.velocity.x = owner.walk_speed * owner.direction
		change_state("none/longjump")
		owner.set_mach_speed(2)
		owner.jump()

	if(owner.is_on_ceiling()):
		owner.sprite.play("roofbonk")
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

