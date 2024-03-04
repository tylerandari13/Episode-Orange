class_name PlayerSpawn
extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.visible = false
#	add_child(load("res://scenes/players/orange.tscn").instantiate())
