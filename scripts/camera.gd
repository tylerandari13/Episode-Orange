class_name PlayerCamera
extends Camera2D

var shake_intensity = 0

func _process(delta):
	position = owner.velocity * 0.2
	offset = Vector2(randi_range(shake_intensity * -1, shake_intensity), randi_range(shake_intensity * -1, shake_intensity))
	shake_intensity -= 1 if shake_intensity > 0 else 0

func shake(amount):
	shake_intensity = amount

func bump():
	var oldtime = Engine.time_scale
	shake(5)
	Engine.time_scale = 0
	await get_tree().create_timer(0.05, true, false, true).timeout
	Engine.time_scale = oldtime
	pass
