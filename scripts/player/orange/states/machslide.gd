extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.mach_speed = 0
	owner.sprite.play("machslide")


# Called every frame when this state is active.
func on_process(delta):
	owner.velocity.x = owner.velocity.x * Global.apply_delta_time(owner.friction, delta)
	if(abs(owner.velocity.x) < 20): change_state("none/ground")
	if(owner.is_on_wall()): change_state("none/bonk")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

