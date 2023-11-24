extends "res://scripts/OrangeState.gd"


# Called when the state machine enters this state.
func on_enter():
	owner.set_ducking(true)


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	var _direction = 0
	if(Input.is_action_pressed("left")):
		_direction -= 1
	if(Input.is_action_pressed("right")):
		_direction += 1
	
	if(_direction == 0):
		owner.velocity.x = owner.velocity.x * 0.8
	else:
		owner.velocity.x = _direction * owner.speed * 0.7
		owner.direction = _direction
	if(owner.is_on_floor()):
		change_state("Duck")

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

