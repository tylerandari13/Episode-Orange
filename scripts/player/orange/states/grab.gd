extends OrangeState

var grab_time = 0.7
var cur_time
var the_velocity

# Called when the state machine enters this state.
func on_enter():
	cur_time = 0
	the_velocity = owner.grab_speed if abs(owner.velocity.x) < owner.grab_speed else owner.velocity.x * owner.direction
	owner.velocity.x = the_velocity * owner.direction
	owner.sprite.play("grab")


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < grab_time): cur_time += delta
	if(owner.is_on_floor()):
		if(cur_time >= grab_time):
			if(Input.is_action_pressed("run")):
				owner.mach_speed = the_velocity
				change_state("none/machrun")
			else:
				change_state("none/ground")
	if(Input.is_action_just_pressed("jump")):
		change_state("none/longjump")
		#owner.mach_speed = owner.walk_speed
	if(owner.is_on_wall_only()):
		owner.mach_speed = owner.walk_speed
		change_state("none/wallrun")
	if((owner.velocity.x > 0 && Input.is_action_pressed("left")) || (owner.velocity.x < 0 && Input.is_action_pressed("right"))):
		owner.velocity.x = 0
		change_state("none/air")
	if(Input.is_action_pressed("down")): change_state("none/grabslide")

	if(owner.is_on_wall() && owner.is_on_floor()):
		owner.sprite.play("bonk")
		change_state("none/bonk")


# Called every physics frame when this state is active.
func on_physics_process(delta):
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

