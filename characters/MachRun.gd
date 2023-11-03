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

var mach1 : float = 0
var mach2 : float = 425
var mach3 : float = 750
var mach4 : float = 1000
var machtop : float = 1500

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
	|| mach < mach3):
		if(character.is_on_floor()):
			if(mach < mach3):
				mach += acceeration
			elif(mach < machtop):
				mach += acceeration / 32
				
	if((direction == 1 && Input.is_action_pressed("left"))
	|| (direction == -1 && Input.is_action_pressed("right"))):
		slide_state.mach = get_mach()
		next_state = slide_state
	character.velocity.x = direction * (speed + mach)

	if(Input.is_action_pressed("up") && get_mach() >= 3):
		next_state = superjump_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && character.is_on_floor()):
		character.velocity.y = character.jump_velocity

func override_speed(speed : float):
	mach_override = true
	mach = speed

func override_direction(_direction : float):
	direction_override = true
	direction = _direction

func get_mach(precise : bool = false):
	if(precise):
		return mach
	else:
		if(mach < mach2):
			return 1
		if(mach >= mach2 && mach < mach3):
			return 2
		if(mach >= mach3 && mach < mach4):
			return 3
		if(mach > mach4):
			return 4
		return 0
