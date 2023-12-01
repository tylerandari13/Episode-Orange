class_name CollectibleSmall
extends CollectibleBase

func set_textures(): return [
	{
		path = "res://images/objects/colllectibles/ticket_small/ticket_small.tres",
		hues = [
			0,
			0.1,
			0.75,
			0.8,
		]
	},
	{
		path = "res://images/objects/colllectibles/token_small/token_small.tres",
		hues = [
			0.05,
			0.8,
		]
	},
]

func on_collected(player : CharacterBody2D):
	pass
