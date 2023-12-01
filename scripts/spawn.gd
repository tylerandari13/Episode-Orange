class_name RoomSpawnPoint
extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_spawn_point(self)
	$AnimatedSprite2D.visible = false
