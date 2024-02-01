class_name Secret
extends Area2D

@export var to_spawn : Secret
@export var exit = false

@onready var sprite = $AnimatedSprite2D
@onready var collision = $Collisions

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_body_entered)

func _body_entered(body : Node2D):
	if(body is Player):
		if(exit):
			body.velocity.y = -1000
			await get_tree().create_timer(1).timeout
			monitoring = false
			collision.collision_layer = 0
		else:
			body.enter_secret(to_spawn)
		sprite.play("sploosh")
