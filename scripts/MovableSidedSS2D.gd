@tool
class_name MovableSidedSS2D
extends SS2D_Shape

@export var sides : Array[MovableSides2D]

@export_group("Map Points")
@export_placeholder("ActionProperty") var _map_points : String = "" : set = _map_points_action

func get_side(name : String) -> MovableSides2D:
	for side in sides:
		if(side.name == name):
			return side
	push_error("Side " + name + "not found.")
	return MovableSides2D.new()

func get_average_position(name : String) -> Vector2:
	var side = get_side(name)
	return Vector2(Global.average(side.points.map(
			func(value):
				return _points._points[value].position.x
				)
			), Global.average(side.points.map(
			func(value):
				return _points._points[value].position.y
				)
			))

func move_side(name : String, position : Vector2):
	var side = get_side(name)
	for point in side.points:
		_points._points[point].position += position

func move_side_to(name : String, position : Vector2, anchor_index = -1):
	var anchor_pos : Vector2
	if(anchor_index < 0):
		pass # average
	else:
		pass

func _map_points_action(thing):
	pass
