extends State

class_name DuckState

@export var ground_state : State

func state_input(_event : InputEvent):
	pass

func state_process(_delta):
	var direction = 0
	if(Input.is_action_pressed("left")):
		direction -= 1
	if(Input.is_action_pressed("right")):
		direction += 1
	
	if(direction == 0):
		character.animated_sprite.play("duck")
	else:
		character.animated_sprite.play("crawl")
	
	character.velocity.x = direction * character.speed * 0.5
	
	if(!Input.is_action_pressed("down")):
		next_state = ground_state

func on_enter():
	character.set_ducking(true)

func on_exit():
	character.set_ducking(false)
