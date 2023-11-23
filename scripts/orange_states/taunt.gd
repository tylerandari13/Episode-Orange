extends "res://scripts/OrangeState.gd"

var cur_time : float

var last_vel : Vector2

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	last_vel = owner.velocity
	owner.taunt_sprite.visible = true
	owner.taunt_sprite.rotation = randi_range(0, 359)


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < owner.taunt_time):
		cur_time += delta
		owner.velocity = Vector2()
	else:
		state_machine.change_state(state_machine._previous_state.get_path())
		owner.velocity = last_vel


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	owner.taunt_sprite.visible = false

