extends OrangeState

var grab_time = 0.7
var cur_time = 0

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.x = max(owner.grab_speed, owner.velocity.abs().x) * owner.direction


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(cur_time < grab_time):
		cur_time += delta
	else:
		if(Input.is_action_pressed("run")):
			change_state("MachRun")
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
	if(owner.is_on_floor()):
		if(event.is_action_pressed("jump")):
			change_state("LongJump")
		if(event.is_action_pressed("down")):
			change_state("GrabSlide")


# Called when the state machine exits this state.
func on_exit():
	cur_time = 0

