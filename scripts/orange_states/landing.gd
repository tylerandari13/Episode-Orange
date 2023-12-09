extends OrangeState

var land_time = 0.3
var cur_time = 0

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time >= land_time):
		change_state("Ground")
	else:
		cur_time += delta


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

