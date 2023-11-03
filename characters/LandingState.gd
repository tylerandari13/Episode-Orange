extends State

class_name LandingState

@export var ground_state : State
var wait_time : float = 0.1

var cur_time : float = 0.0

func on_enter():
	character.velocity.x = 0
	character.animated_sprite.play("duck")
	cur_time = 0.0

func state_process(delta):
	cur_time += delta
	if(cur_time >= wait_time):
		next_state = ground_state
