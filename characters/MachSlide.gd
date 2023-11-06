extends State

class_name MachSLide

@export var mach_state : State
var dir : float = 0

var mach : float = 0

func state_process(_delta):
	if(character.velocity.x > 0):
		character.velocity.x -= character.acceleration * 3
	elif(character.velocity.x < 0):
		character.velocity.x += character.acceleration * 3
	
	if(character.velocity.abs().x < character.acceleration * 3 && character.is_on_floor()):
		mach_state.override_direction(dir)
		mach_state.override_speed(mach_state["mach" + str(mach)] if mach < 4 else mach_state.mach3)
		next_state = mach_state
