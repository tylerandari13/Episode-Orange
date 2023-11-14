extends "res://scripts/OrangeState.gd"

var superjumping : bool = false
var jumpcanceling : bool = false

var roof_time : float = 0.2
var floor_time : float = 0.3
var grab_time : float = 0.5
var current_time : float = 0

var direction = 0

# Called when the state machine enters this state.
func on_enter():
	owner.set_ducking(true)
	direction = owner.direction


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(superjumping):
		if(owner.is_on_ceiling()):
			current_time += delta
			if(current_time > roof_time):
				change_state("Air")
		elif(Input.is_action_just_pressed("run") || Input.is_action_just_pressed("grab")):
			jumpcanceling = true
		if(jumpcanceling):
			current_time += delta
			owner.velocity.y = 0
			if(current_time > grab_time):
				owner.mach = owner.mach3
				owner.direction = direction
				owner.velocity.y = owner.jump_velocity * 0.5
				change_state("MachRun")
	else:
		if(current_time < floor_time):
			if(owner.is_on_floor()):
				current_time += delta
		else:
			if(!Input.is_action_pressed("up")):
				owner.set_ducking(false)
				current_time = 0
				use_gravity = false
				superjumping = true
				owner.velocity.x = 0
				owner.velocity.y = owner.jump_velocity * 1.5
			else:
				use_gravity = true
	if(Input.is_action_pressed("left")):
		if(!superjumping):
			owner.velocity.x = owner.speed * -0.5
		direction = -1
		#character.animated_sprite.flip_h = true
	elif(Input.is_action_pressed("right")):
		if(!superjumping):
			owner.velocity.x = owner.speed * 0.5
		direction = 1
		#character.animated_sprite.flip_h = false
	else:
		owner.velocity.x = 0


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	owner.set_ducking(false)
	superjumping = false
	jumpcanceling = false

