extends PotatoState


# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.get_axis("left", "right") != 0): owner.velocity.x = Input.get_axis("left", "right") * owner.walk_speed * 0.9
	if(Input.is_action_just_pressed("jump")):
		change_state("none/airspin")
		owner.velocity.y = owner.jump_velocity * 1.5
	if(owner.is_on_floor()):
		change_state("none/ground")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass


func spin():
	pass

