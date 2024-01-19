extends OrangeState

var bonk_time = 0.4

var cur_time

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	owner.mach_speed = 0


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < bonk_time):
		cur_time += delta
		owner.velocity = Vector2()
	else:
		change_state("none/ground")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

