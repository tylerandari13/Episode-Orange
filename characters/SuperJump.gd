extends State

class_name SuperJumpState

@export var air_state : State
@export var mach_state : State

var superjumping : bool = false
var jumpcanceling : bool = false

var roof_time : float = 0.2
var floor_time : float = 0.3
var grab_time : float = 0.5
var current_time : float = 0

var direction : float = 0

func on_enter():
	current_time = 0
	direction = 1 if character.velocity.x > 0 else -1
	
func state_process(delta):
	if(superjumping):
		if(character.is_on_ceiling()):
			current_time += delta
			if(current_time > roof_time):
				next_state = air_state
		elif(Input.is_action_just_pressed("run") || Input.is_action_just_pressed("grab")):
			jumpcanceling = true
		if(jumpcanceling):
			current_time += delta
			character.velocity.y = 0
			if(current_time > grab_time):
				mach_state.override_speed(mach_state.mach3)
				mach_state.override_direction(direction)
				character.velocity.y = character.jump_velocity * 0.5
				next_state = mach_state
	else:
		if(current_time < floor_time):
			if(character.is_on_floor()):
				current_time += delta
			character.animated_sprite.play("duck")
		else:
			if(!Input.is_action_pressed("up")):
				current_time = 0
				use_gravity = false
				superjumping = true
				character.animated_sprite.play("jump")
				character.velocity.x = 0
				character.velocity.y = character.jump_velocity * 1.5
	if(Input.is_action_pressed("left")):
		if(!superjumping):
			character.velocity.x = character.speed * -0.5
		direction = -1
		#character.animated_sprite.flip_h = true
	elif(Input.is_action_pressed("right")):
		if(!superjumping):
			character.velocity.x = character.speed * 0.5
		direction = 1
		#character.animated_sprite.flip_h = false
	else:
		character.velocity.x = 0

func on_exit():
	use_gravity = true

	superjumping = false
	jumpcanceling = false
