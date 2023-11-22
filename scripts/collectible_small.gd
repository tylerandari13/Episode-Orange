class_name CollectibleSmall
extends CollectibleBase

func set_texturepaths(): return [
	 
]

func on_collected(player : CharacterBody2D):
	player.add_points(10)
