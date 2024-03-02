class_name SharedUI
extends CanvasLayer

var escaping = false

@onready var point_text = $Points
@onready var combo_bar = $Combo
@onready var combo_label = $TextureRect/Label
@onready var secret_label = $Secrets
@onready var escape_label = $Escape
@onready var time_label = $Time
@onready var escape_y = escape_label.position

func _process(delta):
	if(escaping):
		escape_label.position.y -= 5

func update_points(new_points):
	point_text.text = "Points: " + str(new_points)

func update_combo(new_percentage, number):
	combo_bar.value = new_percentage
	combo_label.text = "" if number == 0 else str(number)

func secret_entered(current, max):
	secret_label.text = "You've found " + str(current) + " out of " + str(max) + " secrets."
	secret_label.visible = true
	await get_tree().create_timer(5).timeout
	secret_label.visible = false

func start_escape(time : int):
	escape_label.position = escape_y
	time_label.visible = true
	escaping = true

func update_escape(time):
	time_label.text = str(time / 60)
