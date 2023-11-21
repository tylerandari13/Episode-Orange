class_name CollectibleSmall
extends CollectibleBase

# func _on_respawn(): pass

func on_collected(player : CharacterBody2D):
	print("GUH!?")
	player.add_points(10)
