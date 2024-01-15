extends Camera2D

var dummy_player : PhysicsBody2D = CharacterBody2D.new()
var current_player : PhysicsBody2D = dummy_player



func init_gui():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	current_player = dummy_player

func init_2d(player : CharacterBody2D):
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	current_player = player

func _process(delta):
	position = current_player.position + (current_player.velocity * 0.2)
