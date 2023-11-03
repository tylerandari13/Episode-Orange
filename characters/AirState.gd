extends State

class_name AirState

@export var ground_state : State
@export var grab_state : State

var speed : float = 0.0

var dir : float = 1.0

func on_enter():
	speed = character.speed

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = ground_state
		
	var direction = 0
	if(Input.is_action_pressed("left")):
		direction -= 1
	if(Input.is_action_pressed("right")):
		direction += 1
	if(direction):
		character.velocity.x = direction * speed
	else:
		character.velocity.x = character.velocity.x * 0.8
		
	if(character.velocity.y < 0):
		character.animated_sprite.play("jump")
	else:
		character.animated_sprite.play("fall")

	if(direction != 0):
		dir = direction

func state_input(event : InputEvent):
	if(event.is_action_pressed("grab")):
		grab_state.dir = dir
		next_state = grab_state
