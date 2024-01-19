extends OrangeState

var move_velocity = 30

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	owner.velocity.y += owner.gravity * delta # this on top of the "use gravity" doubles it
	if(owner.is_on_floor()):
		change_state("none/bonk")
	if(Input.is_action_pressed("left") && owner.velocity.x > owner.walk_speed * -0.5): owner.velocity.x -= move_velocity
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.walk_speed * 0.5): owner.velocity.x += move_velocity


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

