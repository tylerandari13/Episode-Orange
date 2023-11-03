extends CharacterBody2D

@export var speed : float = 300.0
@export var acceleration : float = 10.0
@export var jump_velocity : float = -600.0
@export var velocity_x : float = 0
@export var velocity_y : float = 0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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

		move_and_slide()
