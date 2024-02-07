extends OrangeState

var prevmach

func add_mach(amount, delta):
	owner.mach_speed += Global.apply_delta_time(amount + (owner.get_floor_angle() * 10), delta)


# Called when the state machine enters this state.
func on_enter():
	prevmach = 0


# Called every frame when this state is active.
func on_process(delta):
	if(prevmach != owner.get_mach_speed() && owner.is_on_floor()):
		owner.sprite.play("mach" + str(owner.get_mach_speed()))
	prevmach = owner.get_mach_speed() if owner.is_on_floor() else 0
	enemy_collision_mode = 1 if owner.get_mach_speed() < 3 else 2
	block_damage = owner.get_mach_speed()


# Called every physics frame when this state is active.
func on_physics_process(delta): if(Input.is_action_pressed("run")):
	owner.velocity.x = (owner.mach_speed + owner.walk_speed) * owner.direction
	if(owner.is_on_floor()): if(owner.mach_speed < owner.mach3): # done like this for readability
		add_mach(owner.acceleration, delta)
	elif((owner.velocity.x < 0 && Input.is_action_pressed("left")) || (owner.velocity.x > 0 && Input.is_action_pressed("right"))):
		add_mach(owner.acceleration / 2, delta)
	#else:
	#	owner.mach_speed -= Global.apply_delta_time(owner.acceleration, delta)
	if((owner.velocity.x > 0 && Input.is_action_pressed("left")) || (owner.velocity.x < 0 && Input.is_action_pressed("right"))):
		change_state("none/machdrift")
	
	if(owner.get_mach_speed() > 2 && (Input.is_action_pressed("superjump") || Input.is_action_pressed("up"))): change_state("none/superjumpwindup")

	if(owner.is_on_wall() && owner.is_on_floor() && owner.get_wall_normal().y != owner.direction):
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

