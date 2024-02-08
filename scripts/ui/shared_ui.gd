extends CanvasLayer

@onready var point_text = $Points
@onready var combo_bar = $Combo
@onready var combo_label = $TextureRect/Label
@onready var secret_label = $Secrets

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