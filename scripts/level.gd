class_name Level
extends Node2D

@export_category("Level Settings")
@export var s_rank_score = NAN
@export_group("Secret Areas")
@export var secrets = NAN

var room_cache = {}
#var collectibles = []
var player : Player
var backgrounds = {}
var spawn

@onready var set_s_rank = is_nan(s_rank_score)
@onready var set_secrets = is_nan(secrets)

func _ready():
	if(set_s_rank): s_rank_score = 0
	if(set_secrets): secrets = 0

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
	#collectibles.append(collectible)

func add_s_rank_score(score): if(set_s_rank): s_rank_score += score
func add_secret(inc = 1): if(set_secrets): secrets += inc

func set_player(_player : Player):
	player = _player

func set_spawn(spawnpoint):
	spawn = spawnpoint

func add_background(room_name, background):
	if(typeof(room_name) == TYPE_ARRAY):
		for room in room_name:
			add_background(room, background)
	elif(typeof(room_name) == TYPE_STRING):
		if(!room_name in background): backgrounds[room_name] = []
		backgrounds[room_name].append(background)

func toggle_background(room):
	var on_rooms = []
	for room_name in backgrounds:
		if(room_name == room.name):
			on_rooms.append_array(backgrounds[room_name])
		else:
			for _room in backgrounds[room_name]: _room.visible = false
	for _room in on_rooms:
		_room.visible = true
