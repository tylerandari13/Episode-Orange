extends Node

var rooms : Dictionary

var collectibles : Array

func add_room(room : Room):
	print("added room ", room)
	rooms[room.name] = room
func get_room(room :String):
	return rooms[room]

func add_collectible(collectible : CollectibleBase):
	collectibles.append(collectible)
