extends OrangeState

var cur_time : float = 0
var roof_time : float = 0.2

# Called when the state machine enters this state.
func on_enter():
	pass


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.is_action_pressed("run")):
		if(owner.is_on_wall()):
			owner.velocity.x = owner.direction
			owner.velocity.y = owner.mach * -1
			owner.mach += 10
		else:
			owner.velocity.y = 0
			if(!Input.is_action_pressed("jump")):
				change_state("MachRun")
	else:
		owner.velocity.y = -100
		change_state("Air")

	if(owner.is_on_ceiling()):
		cur_time += delta
		if(cur_time >= roof_time):
			change_state("Air")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		change_state("WallJump")


# Called when the state machine exits this state.
func on_exit():
	pass

