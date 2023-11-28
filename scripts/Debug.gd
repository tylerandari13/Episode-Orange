extends Node

var current_level : Node2D
var degrees = rad_to_deg(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_parent().get_children():
		if child is Level:
			current_level = child

	if(Input.is_key_label_pressed(KEY_F11)):
		Players.get_player("orange").state_machine.change_state("Noclip")

	if(Input.is_key_label_pressed(KEY_F12)):
		if(Input.is_action_pressed("left")):
			current_level.rotate(deg_to_rad(-1))
		if(Input.is_action_pressed("right")):
			current_level.rotate(deg_to_rad(1))
		if(Input.is_action_pressed("up")):
			current_level.scale.x -= 0.01
			current_level.scale.y -= 0.01
		if(Input.is_action_pressed("down")):
			current_level.scale.x += 0.01
			current_level.scale.y += 0.01
