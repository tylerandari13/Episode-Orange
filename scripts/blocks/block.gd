class_name Block
extends StaticBody2D

@export var block_damage : int
@export var sprite : AnimatedSprite2D

@onready var collision = $Area2D

var broken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.body_entered.connect(touch)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func touch(body : Node2D):
	if(body is Player):
		if(body.get_block_damage() >= block_damage && _on_touched(body)):
			broken = true
			collision_layer = 0
			sprite.modulate.a = 0

func _on_touched(player : Player) -> bool: return true
