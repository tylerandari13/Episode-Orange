extends State

class_name SuperJumpState

@export var air_state : State

var superjumping : bool = false

var roof_time : float = 0.2
var floor_time : float = 0.3
var current_time : float = 0

func on_enter():
	current_time = 0
	
func state_process(delta):
	if(superjumping):
		if(character.is_on_ceiling()):
			current_time += delta
		if(current_time > roof_time):
			next_state = air_state
	else:
		if(current_time < floor_time):
			current_time += delta
			character.animated_sprite.play("duck")
		else:
			if(!Input.is_action_pressed("up")):
				current_time = 0
				use_gravity = false
				superjumping = true
				character.animated_sprite.play("jump")
				character.velocity.y = character.jump_velocity * 1.5
		if(Input.is_action_pressed("left")):
			character.velocity.x = character.speed * -0.5
		elif(Input.is_action_pressed("right")):
			character.velocity.x = character.speed * 0.5
		else:
			character.velocity.x = 0

func on_exit():
	use_gravity = true
	superjumping = false
