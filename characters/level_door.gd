extends Area2D

@export var scene : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("up")):
		for body in get_overlapping_bodies():
			if("is_player" in body):
				get_tree().change_scene_to_file(scene)
