class_name Level
extends Node2D

@export_category("Level Settings")
@export var s_rank_score = NAN
@export_group("Secret Areas")
@export var secrets = NAN

var rooms = {}
var collectibles = []

var set_s_rank

func _ready():
	set_s_rank = is_nan(s_rank_score)

func add_room(room):
	rooms[room.name] = room
func get_room(room):
	return rooms[room]

func add_collectible(collectible):
	add_s_rank_score(collectible.worth)
	collectibles.append(collectible)

func add_s_rank_score(score): if(set_s_rank): s_rank_score += score
