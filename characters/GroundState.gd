extends State

class_name GroundState

@export var air_state : State
@export var mach_state : State

var speed : float = 0.0
var jump_velocity : float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO

func on_enter():
	speed = character.speed
	jump_velocity = character.jump_velocity

func state_process(_delta):
		direction = Input.get_vector("left", "right", "up", "down")
		if(direction):
			character.velocity.x = direction.x * speed
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, speed)

		if(character.velocity.x == 0):
			character.animated_sprite.play("default")
		else:
			character.animated_sprite.play("run")
		
		if(!character.is_on_floor()):
			next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		character.velocity.y = jump_velocity
	if(event.is_action_pressed("run")):
		next_state = mach_state
