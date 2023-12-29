class_name Collectible
extends Area2D

@export_category("Collectible")
@export var worth = 0
@export var respawn_during_escape = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(try_collect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func try_collect(body):
	if(body is Player):
		_on_collected(body)

func _on_collected(player): pass
