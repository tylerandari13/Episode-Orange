extends Node

func spawn_player(name : String, parent : Node = self):
	var player = load("res://characters/orange.tscn").instantiate()
	parent.add_child(player)
	return player

func get_player(name : String):
	for child in get_children():
		if(child is Player):
			return child

func enable_player(name : String, enabled : bool):
	get_player(name).disabled = !enabled
	get_player(name).visible = enabled
