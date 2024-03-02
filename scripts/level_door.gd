class_name LevelDoor
extends DoorBase

@export_file var level = ""
@export_enum("Open", "Hide", "Custom") var escape_mode : int

func _entered(player : Player):
	player.enter_level(level)
