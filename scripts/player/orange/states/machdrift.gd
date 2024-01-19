extends OrangeState

var slide_time = 1

var cur_time
var sliding

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	sliding = true
	owner.direction = owner.direction * -1
	owner.sprite.play("machdrift")


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
# This should be redone at some point.
func on_physics_process(delta):
	if(sliding):
		owner.velocity.x = owner.velocity.x *  Global.apply_delta_time(owner.friction, delta)
		if (abs(owner.velocity.x) < 300): 
			owner.velocity.x = 0
	else:
		owner.velocity.x = 0
	if(abs(owner.velocity.x) < 5): sliding = false

	if((!sliding || cur_time >= slide_time) && owner.is_on_floor()):
		owner.set_mach_speed(min(owner.get_mach_speed(), 3))
		change_state("none/machrun")

	if(cur_time < slide_time): cur_time += delta


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

