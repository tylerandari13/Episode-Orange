extends State

class_name AirState

@export var ground_state : State

var speed : float = 0.0

func on_enter():
	speed = character.speed

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = ground_state
		
	var direction = Input.get_vector("left", "right", "up", "down")
	if(direction):
		character.velocity.x = direction.x * speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
		
	if(character.velocity.y < 0):
		character.animated_sprite.play("jump")
	else:
		character.animated_sprite.play("fall")
