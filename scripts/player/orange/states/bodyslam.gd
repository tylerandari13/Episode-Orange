extends OrangeState

var move_velocity = 30

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity


# Called every frame when this state is active.
func on_process(delta):
	block_damage = owner.get_mach_speed(owner.velocity.y)


# Called every physics frame when this state is active.
func on_physics_process(delta):
	owner.velocity.y += owner.gravity * delta # this on top of the "use gravity" doubles it

	if(owner.is_on_floor()):
		#print(int(rad_to_deg(owner.get_floor_normal().angle()) + 90))
		#print(owner.get_floor_normal().x)
		#owner.find_child("RayCast2D").target_position = owner.get_floor_normal() * 150
		if(abs(int(rad_to_deg(owner.get_floor_normal().angle()) + 90)) <= 15):
			change_state("none/bonk")
		else:
			owner.direction = -1 if owner.get_floor_normal().x < 0 else 1
		#	owner.mach_speed = owner.mach3 / owner.get_position_delta().y * 5
		#	print(owner.mach_speed)
		#	owner.mach_speed = min(owner.mach_speed, owner.mach3)
			change_state("none/machrun")

	if(Input.is_action_pressed("left") && owner.velocity.x > owner.walk_speed * -0.5): owner.velocity.x -= move_velocity
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.walk_speed * 0.5): owner.velocity.x += move_velocity


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

