class_name CollectibleRandomHue
extends Collectible


# Called when the node enters the scene tree for the first time.
func ready():
	sprite.material = sprite.material.duplicate(true)
	sprite.material.set_shader_parameter("Shift_Hue", (randi() % 10) * 0.1)
