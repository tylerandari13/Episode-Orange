class_name Level
extends Node2D

@export_category("Level Settings")
@export var s_rank_score = NAN
@export_group("Secret Areas")
@export var secrets = NAN

var room_cache = {}
var collectibles = []
var player : Player

@onready var set_s_rank = is_nan(s_rank_score)

func _ready():
	pass

func get_room(room):
	if(room in room_cache):
		return room_cache[room]
	else:
		for _room in get_tree().get_nodes_in_group("rooms"):
			room_cache[_room.name] = _room
			if(room in room_cache):
				return room_cache[room]
			else:
				push_error("No room named \"" + str(room) + "\" in level.")

func add_collectible(collectible):
	add_s_rank_score(collectible.worth)
	collectibles.append(collectible)

func add_s_rank_score(score): if(set_s_rank): s_rank_score += score

func set_player(_player : Player):
	player = _player
