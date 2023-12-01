extends Node

var rooms : Dictionary

func add_room(room : Room):
	print("added room ", room)
	rooms[room.name] = room
func get_room(room :String):
	return rooms[room]
