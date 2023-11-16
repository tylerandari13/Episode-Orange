extends Node

func spawn_player(name : String, parent : Node = self):
	var player = load("res://characters/orange.tscn").instantiate()
	var camera = load("res://characters/playercamera.tscn").instantiate()
	var container = Node2D.new()
	player.camera = camera
	container.add_child(camera)
	container.add_child(player)
	container.name = name
	parent.add_child(container)
	return container

func get_player(name : String):
	if(get_node(name)):
		for child in get_node(name).get_children():
			if(child is Player):
				return child
