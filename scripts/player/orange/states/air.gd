extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.get_axis("left", "right") != 0): owner.velocity.x = Input.get_axis("left", "right") * owner.walk_speed
	owner.sprite.play("jump" if owner.velocity.y <= 0 else "fall")
	if(owner.is_on_floor()):
		owner.sprite.play("default")
		change_state("none/ground")
	if(Input.is_action_pressed("down")):
		owner.sprite.play("bodyslam")
		change_state("none/bodyslam")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

