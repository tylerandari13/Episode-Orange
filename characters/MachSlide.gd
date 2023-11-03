extends State

class_name MachSLide

@export var mach_state : State
var dir : float

var mach : float = 0

func state_process(_delta):
	if(character.velocity.x > 0):
		character.velocity.x -= character.acceleration * 3
		dir = 1
	elif(character.velocity.x < 0):
		character.velocity.x += character.acceleration * 3
		dir = 0
	
	if(character.velocity.abs().x < character.acceleration * 3 && character.is_on_floor()):
		#character.velocity.x = character.speed * -1 if dir else character.speed
		mach_state.override_direction(-1 if dir else 1)
		mach_state.override_speed(mach_state["mach" + str(mach)])
		next_state = mach_state
