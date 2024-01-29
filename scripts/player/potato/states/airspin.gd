extends PotatoState

var move_velocity = 30

# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.is_action_pressed("left") && owner.velocity.x > owner.walk_speed * -1): owner.velocity.x -= move_velocity
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.walk_speed): owner.velocity.x += move_velocity


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass


# Called when the player pressed Grab (Potato should be able to spin in almost all states)
func spin():
	pass

