class_name CollectibleRandomHue
extends Collectible


# Called when the node enters the scene tree for the first time.
func ready():
	sprite.material = Global.hue_shader((randi() % 10) * 0.1)
