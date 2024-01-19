extends OrangeState

var cancel_time = 0.5

var current_time
var canceling

# Called when the state machine enters this state.
func on_enter():
	current_time = 0
	canceling = false
	owner.velocity = Vector2(0, owner.jump_velocity * 2)
	owner.sprite.play("superjump")


# Called every frame when this state is active.
func on_process(delta):
	if(Input.get_axis("left", "right") != 0): owner.direction = Input.get_axis("left", "right")
	if(Input.is_action_just_pressed("run") || Input.is_action_just_pressed("grab")):
		canceling = true
		owner.sprite.play("superjumpcancel1")
	if(canceling):
		owner.velocity = Vector2()
		if(current_time < cancel_time):
			current_time += delta
		else:
			owner.mach_speed = owner.mach3
			owner.sprite.play("superjumpcancel2")
			change_state("none/machrun")
			owner.velocity.y = owner.jump_velocity * 0.5
	if(owner.is_on_ceiling()):
		owner.sprite.play("roofbonk")
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

