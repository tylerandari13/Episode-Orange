extends CharacterBody2D

@export_category("Orange")
@export_group("Speed")
@export var speed : float = 400.0
@export var jump_velocity : float = -700.0

@export_group("Mach Speed")
@export var mach1 : float = 0
@export var mach2 : float = 425
@export var mach3 : float = 750
@export var mach4 : float = 1000
@export var machtop : float = 1500

@export_group("Misc")
@export var is_player : bool = true

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

func get_mach(precise : bool = false, _mach = mach):
	if(precise):
		return _mach
	else:
		if(_mach < mach2):
			return 1
		if(_mach >= mach2 && _mach < mach3):
			return 2
		if(_mach >= mach3 && _mach < mach4):
			return 3
		if(_mach >= mach4):
			return 4
		return 0
