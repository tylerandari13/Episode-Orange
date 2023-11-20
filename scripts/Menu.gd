extends Node

@export var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Players.enable_player("orange", false)
	InGameUI.visible = false
	camera.make_current()
