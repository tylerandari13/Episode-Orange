class_name CollectibleSmall
extends CollectibleBase

@export var number_text : Label
@export var points = 10

@onready var origin_y = number_text.position.y

func set_texturepaths(): return [
	 "res://images/objects/colllectibles/ticket_small/ticket_small.tres",
	"res://images/objects/colllectibles/token_small/token_small.tres",
]

func on_collected(player : CharacterBody2D):
	player.add_points(points)
	number_text.text = str(points)
	number_text.visible = true

func _ready():
	number_text.visible = false

func _process(delta):
	if(collected):
		if(abs(number_text.position.y - origin_y) > 300):
			number_text.position.y = origin_y
			number_text.visible = false
		else:
			number_text.position.y -= 5
