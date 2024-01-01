extends PlayerState

var taunt_time = 0.3

var prev_vel
var cur_time

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	prev_vel = owner.velocity
	owner.velocity = Vector2()


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < taunt_time):
		cur_time += delta
	else:
		state_machine.previous_state()
		owner.velocity = prev_vel


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

