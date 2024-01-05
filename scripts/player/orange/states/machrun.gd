extends OrangeState

var prevmach

# Called when the state machine enters this state.
func on_enter():
	prevmach = 0


# Called every frame when this state is active.
func on_process(delta):
	if(prevmach != owner.get_mach_speed() && owner.is_on_floor()):
		owner.sprite.play("mach" + str(owner.get_mach_speed()))
	prevmach = owner.get_mach_speed() if owner.is_on_floor() else 0


# Called every physics frame when this state is active.
func on_physics_process(delta): if(Input.is_action_pressed("run")):
	owner.velocity.x = (owner.mach_speed + owner.walk_speed) * owner.direction
	if(owner.is_on_floor()): if(owner.mach_speed < owner.mach3): # done like this for readability
		owner.mach_speed += Global.apply_delta_time(owner.acceleration, delta)
	elif((owner.velocity.x < 0 && Input.is_action_pressed("left")) || (owner.velocity.x > 0 && Input.is_action_pressed("right"))):
		owner.mach_speed += Global.apply_delta_time(owner.acceleration, delta)
	#else:
	#	owner.mach_speed -= Global.apply_delta_time(owner.acceleration, delta)
	if((owner.velocity.x > 0 && Input.is_action_pressed("left")) || (owner.velocity.x < 0 && Input.is_action_pressed("right"))):
		change_state("none/machdrift")
	
	if(owner.get_mach_speed() > 2 && Input.is_action_pressed("superjump")): change_state("none/superjumpwindup")

	if(owner.is_on_wall() && owner.is_on_floor()):
		owner.sprite.play("machbonk" if owner.get_mach_speed() > 2 else "bonk")
		change_state("none/bonk")
else:
	change_state("none/machslide")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

