extends State

class_name GroundState

@export var air_state : State
@export var mach_state : State
@export var grab_state : State

var speed : float = 0.0
var jump_velocity : float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : float = 0
var last_dir : float = 0

func on_enter():
	speed = character.speed
	jump_velocity = character.jump_velocity

func state_process(_delta):
		direction = 0
		if(Input.is_action_pressed("left")):
			direction -= 1
		if(Input.is_action_pressed("right")):
			direction += 1
		
		if(direction != 0):
			character.velocity.x = direction * speed
		else:
			character.velocity.x = character.velocity.x * 0.7

		if(character.velocity.x == 0):
			character.animated_sprite.play("default")
		else:
			character.animated_sprite.play("run")
		
		if(!character.is_on_floor()):
			next_state = air_state
		
		if(direction != 0):
			last_dir = direction

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		character.velocity.y = jump_velocity
	if(event.is_action_pressed("run")):
		next_state = mach_state
	if(event.is_action_pressed("grab")):
		grab_state.dir = last_dir
		next_state = grab_state
