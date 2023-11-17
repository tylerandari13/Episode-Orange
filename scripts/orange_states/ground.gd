extends "res://scripts/OrangeState.gd"

# Call `change_state(state : String)` to change the state.
# Call `is_current_state()` to check if this state is also the surrent state on the state machine.

# Called when the state machine enters this state.
func on_enter():
	owner.mach = 0


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
		owner.velocity.x = owner.velocity.x * 0.7
	else:
		owner.velocity.x = _direction * owner.speed
		owner.direction = _direction
	if(!owner.is_on_floor()):
		change_state("Air")

	if(Input.is_action_pressed("run")):
		change_state("MachRun")

# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		owner.velocity.y = owner.jump_velocity
	if(event.is_action_pressed("grab")):
		owner.try_grab()
	if(event.is_action_pressed("down")):
		change_state("Duck")


# Called when the state machine exits this state.
func on_exit():
	pass
