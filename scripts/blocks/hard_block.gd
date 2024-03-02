class_name HardBlock
extends Block

func _on_touched(player : Player) -> bool:
	player.camera.shake(20)
	return true
