class_name Block
extends StaticBody2D

@export var block_damage : int
@export var sprite : AnimatedSprite2D

var broken = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func touch(body : Node2D):
	if(body is Player):
		if(body.get_block_damage() >= block_damage && _on_touched(body)):
			broken = true
			collision_layer = 0
			sprite.modulate.a = 0
			await get_tree().create_timer(5).timeout
			queue_free()

func _on_touched(player : Player) -> bool: return true
