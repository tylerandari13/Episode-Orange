class_name CollectibleBig
extends CollectibleBase

func set_textures(): return [
	{
		path = "res://images/objects/colllectibles/ticket_big/ticket_big.tres",
		hues = [
			0,
			0.1,
			0.75,
			0.8,
		]
	},
]

func on_collected(player : CharacterBody2D):
	pass
