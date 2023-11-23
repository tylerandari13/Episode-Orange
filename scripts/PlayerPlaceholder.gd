extends Node

var passed_self : bool = false

func _ready():
	for child in get_parent().get_children():
		if(child is Node2D && child.z_index == 0):
			if(passed_self):
				child.z_index = 100
			else:
				child.z_index = -100
		if(child == self):
			passed_self = true
