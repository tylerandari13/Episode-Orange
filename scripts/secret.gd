class_name Secret
extends Area2D

@export var to_spawn : Secret

@onready var sprite = $AnimatedSprite2D
@onready var collision = $Collisions

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_body_entered)

func _body_entered(body : Node2D):
	if(body is Player):
		to_spawn.exit()
		body.enter_secret(to_spawn)
		sprite.play("sploosh")

func exit():
	monitoring = false
	collision.collision_layer = 0
	sprite.play("disappear")
	await get_tree().create_timer(1).timeout
	visible = false
