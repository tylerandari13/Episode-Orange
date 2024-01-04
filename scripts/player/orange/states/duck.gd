extends OrangeState


# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	owner.velocity.x = (Input.get_axis("left", "right") * owner.walk_speed) * 0.5
	if(!Input.is_action_pressed("down") && owner.can_unduck()): change_state("none/ground")
	if(!owner.is_on_floor()):
		owner.velocity.y = owner.velocity.y * 0.75
		change_state("none/duckjump")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

