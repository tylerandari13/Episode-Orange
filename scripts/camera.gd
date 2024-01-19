extends Camera2D

func _process(delta):
	position = owner.velocity * 0.2
