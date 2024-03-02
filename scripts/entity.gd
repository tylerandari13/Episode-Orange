class_name Entity
extends CharacterBody2D

@export var use_health = true
@export var health : int = 1

@export var sprite : AnimatedSprite2D

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.flip_h = true if direction > 0 else false

func _physics_process(delta):
	if(!is_on_floor() && use_gravity()):
		velocity.y += gravity * delta
	if(use_friction()): velocity.x = velocity.x * 0.9

func use_gravity() -> bool: return true
func use_friction() -> bool: return is_on_floor()
