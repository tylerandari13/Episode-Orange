class_name Player
extends CharacterBody2D

@export var state_machine : FiniteStateMachine
@export var sprite : AnimatedSprite2D

var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if(!is_on_floor() && state_machine.current_state.use_gravity): velocity.y += gravity * delta
	if(state_machine.current_state.use_friction): velocity.x = velocity.x * 0.7
	if(state_machine.current_state.decide_direction_based_on_velocity):
		if(velocity.x > 0):
			direction = 1
		if(velocity.x < 0):
			direction = -1

	sprite.flip_h = direction < 0

	if(velocity.x > 0):
		direction = 1
	if(velocity.x < 0):
		direction = -1

	move_and_slide()

	physics_process(delta)

func physics_process(delta): pass
