extends State

class_name MachState

var speed : float = 0.0
var acceeration : float = 0.0

@export var ground_state : State
@export var slide_state : State
@export var superjump_state : State

var mach : float = 0.0
var direction : float = 0.0

var mach_override : bool = false
var direction_override : bool = false

func on_enter():
	speed = character.speed
	acceeration = character.acceleration
	if(mach_override):
		mach_override = false
	else:
		mach = 0
	if(direction_override):
		direction_override = false
	else:
		direction = ((float(character.animated_sprite.flip_h) * 2) - 1) * -1

func state_process(_delta):
	if(!Input.is_action_pressed("run") && character.is_on_floor()):
		next_state = ground_state

	if((direction == -1 && Input.is_action_pressed("left"))
	|| (direction == 1 && Input.is_action_pressed("right"))
	|| mach < 300):
		if(character.is_on_floor() && mach < 750):
			mach += acceeration
	if((direction == 1 && Input.is_action_pressed("left"))
	|| (direction == -1 && Input.is_action_pressed("right"))):
		next_state = slide_state
	character.velocity.x = direction * (speed + mach)

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && character.is_on_floor()):
		character.velocity.y = character.jump_velocity
	if(event.is_action_pressed("up")):
		next_state = superjump_state

func override_speed(speed : float):
	mach_override = true
	mach = speed

func override_direction(_direction : float):
	direction_override = true
	direction = _direction
