extends CharacterBody2D

@export var speed : float = 400.0
@export var is_player : bool = true
@export var jump_velocity : float = -700.0

@onready var state_machine : FiniteStateMachine = $FiniteStateMachine
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var stand_collision : CollisionShape2D = $StandCollision
@onready var duck_collision : CollisionShape2D = $DuckCollision

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity") 
var mach : float = 0
var direction : float = 1

func _physics_process(delta):
	if(!is_on_floor() && state_machine.current_state.use_gravity):
		velocity.y += gravity * delta
	sprite.flip_h = true if direction < 0 else false
	move_and_slide()

func set_ducking(ducking : bool):
	stand_collision.disabled = ducking
	duck_collision.disabled = !ducking
