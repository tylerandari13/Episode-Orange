extends State

class_name WallRunState

@export var air_state : State
@export var long_state : State
@export var mach_state : State

var speed : float = 0
var speed_overriode : bool = false

var roof_time : float = 0.2

var direction : float = 0
var cur_time : float = 0

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		character.velocity.x = mach_state.mach2 * direction * -1
		next_state = long_state

func state_process(delta):
	if(character.is_on_wall()):
		character.velocity.x = direction
		character.velocity.y = speed * -1
		speed += character.acceleration
	else:
		next_state = air_state

	if(character.is_on_ceiling()):
		cur_time += delta
		if(cur_time >= roof_time):
			next_state = air_state

func on_enter():
	if(speed_overriode):
		speed_overriode = false
	else:
		speed = 0

func on_exit():
	cur_time = 0

func override_speed(_speed : float):
	speed_overriode = true
	speed = _speed
