class_name LevelDoor
extends DoorBase

enum EscapeMode {OPEN, HIDE}

@export_file var level = ""
@export var escape_mode : EscapeMode

func _entered(player : Player):
	player.enter_level(level)
