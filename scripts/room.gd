class_name Room
extends Area2D

@export var boundaries : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rooms")
	body_entered.connect(_player_entered)
	boundaries.modulate.a = 0

func _player_entered(player):
	if(player is Player):
		player.update_room(self)
