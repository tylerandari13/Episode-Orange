extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.sprite.play("wallrun")


# Called every frame when this state is active.
func on_process(delta):
	if(Input.is_action_pressed("run")):
		if(owner.is_on_wall()):
			owner.mach_speed += owner.acceleration
			owner.velocity = Vector2(owner.direction, owner.mach_speed * -0.75)
		else:
			owner.velocity = Vector2(owner.mach_speed * owner.direction, 0)
			change_state("none/machrun")

		if(Input.is_action_just_pressed("jump")):
			owner.direction = owner.get_wall_normal().x
			change_state("none/longjump")
			owner.velocity = Vector2(owner.walk_speed * owner.direction, owner.jump_velocity)
			owner.mach_speed = owner.mach3 * 0.5

		if(owner.is_on_ceiling()):
			owner.sprite.play("roofbonk")
			change_state("none/bonk")
	else:
		owner.velocity = Vector2()
		change_state("none/air")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

