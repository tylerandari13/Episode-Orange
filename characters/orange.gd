extends CharacterBody2D

@export var speed : float = 300.0
@export var acceleration : float = 10.0
@export var jump_velocity : float = -600.0
@export var velocity_x : float = 0
@export var velocity_y : float = 0
@export var is_player : bool = true

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine

@onready var stand_collision : CollisionShape2D = $StandCollision
@onready var duck_collision : CollisionShape2D = $DuckCollision

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0

func _physics_process(delta):
	# Add the gravity.
	if(!is_on_floor() && state_machine.current_state.use_gravity):
		velocity.y += gravity * delta
		
	if(state_machine.current_state.use_friction):
		velocity_x = velocity_x * 0.7

	if(state_machine.current_state.use_directions):
		if(velocity.x > 0):
			animated_sprite.flip_h = false
		elif(velocity.x < 0):
			animated_sprite.flip_h = true

	direction = ((float(animated_sprite.flip_h) * 2) - 1) * -1

	move_and_slide()

func set_ducking(ducking):
	stand_collision.disabled = ducking
	duck_collision.disabled = !ducking
