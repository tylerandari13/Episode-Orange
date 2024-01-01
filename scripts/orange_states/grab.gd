extends PlayerState

var grab_time = 0.7
var cur_time

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	owner.velocity.x = owner.grab_speed * owner.direction if abs(owner.velocity.x) < owner.grab_speed else owner.velocity.x


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < grab_time): cur_time += delta
	if(cur_time >= grab_time && owner.is_on_floor()):
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

