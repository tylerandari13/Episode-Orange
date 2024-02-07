class_name Block
extends StaticBody2D

@export var block_damage : int

@onready var collision = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.body_entered.connect(_touched)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _touched(body : Node2D):
	if(body is Player):
		if(body.get_block_damage() >= block_damage):
			pass
		print(body.get_block_damage(), " : ", body.get_mach_speed())
