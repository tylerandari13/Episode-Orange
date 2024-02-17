class_name PointBlock
extends Block

@export var worth = 0
@export var point_text : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	point_text.text = str(worth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): if(broken): point_text.position.y -= 5

func _on_touched(player : Player) -> bool:
	player.add_points(worth)
	point_text.visible = true
	return true
