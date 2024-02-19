class_name PlayerCamera
extends Camera2D


func _process(delta):
	position = owner.velocity * 0.2


func bump():
#	var oldtime = Engine.time_scale
#	Engine.time_scale = 0
#	await get_tree().create_timer(0.05, true, false, true).timeout
#	Engine.time_scale = oldtime
	pass
