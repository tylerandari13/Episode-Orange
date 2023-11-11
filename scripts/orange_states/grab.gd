extends "res://scripts/OrangeState.gd"

var grab_time = 0.7
var cur_time = 0

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.x = owner.grab_speed * owner.direction
	owner.mach = owner.grab_speed


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(cur_time < grab_time):
		cur_time += delta
	else:
		change_state("Ground")
	if(owner.is_on_wall()):
		if(owner.is_on_floor()):
			owner.velocity.y = -150
			change_state("Air")
		else:
			change_state("WallRun")
	if((owner.direction == 1 && Input.is_action_pressed("left"))
		|| (owner.direction == -1 && Input.is_action_pressed("right"))):
		owner.direction = owner.direction * -1
		owner.velocity.x = 0
		change_state("Ground")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		change_state("LongJump")


# Called when the state machine exits this state.
func on_exit():
	cur_time = 0
