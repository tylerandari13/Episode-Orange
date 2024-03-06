class_name LevelDoor
extends DoorBase

enum EscapeMode {OPEN, HIDE}

@export_file var level = ""
@export var escape_mode : EscapeMode
@export var is_exit = false

var old_layer = collision_layer

func _ready():
	Global.get_level().escape_started.connect(_escape_started)
	$Sprite2D.visible = false

func _escape_started():
	match(escape_mode):
		EscapeMode.OPEN:
			collision_layer = old_layer
		EscapeMode.HIDE:
			visible = false

func _entered(player : Player):
	if(is_exit):
		if(player.escaping):
			player.finish_level()
	else:
		player.enter_level(level)

func become_exit():
	is_exit = true
	collision_layer = 0
