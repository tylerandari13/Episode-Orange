extends State

class_name MachState

var speed : float = 0.0
var acceeration : float = 0.0

@export var ground_state : State
@export var slide_state : State
@export var superjump_state : State
@export var grab_state : State
@export var wall_state : State
@export var dive_state : State
@export var roll_state : State

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
		character.mach = 0
	if(direction_override):
		direction_override = false
	else:
		direction = character.direction

func state_process(_delta):
	if(!Input.is_action_pressed("run") && character.is_on_floor()):
		next_state = ground_state

	if((direction == -1 && Input.is_action_pressed("left"))
	|| (direction == 1 && Input.is_action_pressed("right"))
	|| character.mach < mach3):
		if(character.is_on_floor()):
			if(character.mach < mach3):
				character.mach += acceeration
			elif(character.mach < machtop):
				character.mach += acceeration / 32
				
	if((direction == 1 && Input.is_action_pressed("left"))
	|| (direction == -1 && Input.is_action_pressed("right"))):
		slide_state.dir = direction * -1
		next_state = slide_state
	character.velocity.x = direction * (speed + character.mach)
	
	if(character.is_on_wall()):
		if(character.is_on_floor()):
			if(get_mach() > 1):
				character.velocity.x = -250 * direction
			character.velocity.y = -250
			next_state = ground_state
		else:
			wall_state.direction = direction
			wall_state.override_speed(character.mach)
			next_state = wall_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && character.is_on_floor()):
		character.velocity.y = character.jump_velocity
	if(event.is_action_pressed("grab")):
		grab_state.dir = direction
		next_state = grab_state
	if(Input.is_action_pressed("up") && get_mach() >= 3):
		next_state = superjump_state
	if(Input.is_action_pressed("down")):
		if(character.is_on_floor()):
			roll_state.override_speed(speed)
			next_state = roll_state
		else:
			dive_state.override_speed(speed)
			next_state = dive_state

func override_speed(_speed : float):
	mach_override = true
	character.mach = _speed

func override_direction(_direction : float):
	direction_override = true
	direction = _direction

func get_mach(precise : bool = false, _mach = character.mach):
	if(precise):
		return _mach
	else:
		if(_mach < mach2):
			return 1
		if(_mach >= mach2 && _mach < mach3):
			return 2
		if(_mach >= mach3 && _mach < mach4):
			return 3
		if(_mach > mach4):
			return 4
		return 0
