class_name CollectibleSmall
extends CollectibleBase

func set_texturepaths(): return [
	 "res://images/objects/colllectibles/ticket_small/ticket_small.tres"
]

func on_collected(player : CharacterBody2D):
	player.add_points(10)
