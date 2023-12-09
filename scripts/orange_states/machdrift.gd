extends OrangeState

var slide_time : float = 0.7

var cur_time : float = 0

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if((owner.direction > 0 && owner.velocity.x < 0) || (owner.direction < 0 && owner.velocity.x > 0) || cur_time < slide_time):
		cur_time += delta
		owner.velocity.x += 1700 * owner.direction * delta
	else:
		if(owner.is_on_floor()):
			owner.mach = owner["mach" + str(owner.get_mach())] if owner.get_mach() < 4 else owner.mach3
			change_state("MachRun")
		else:
			owner.velocity.x = 0


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

