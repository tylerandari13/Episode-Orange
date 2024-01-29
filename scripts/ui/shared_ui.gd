extends CanvasLayer

@onready var point_text = $Control/Points
@onready var combo_bar = $Control/Combo
@onready var combo_label = $Control/TextureRect/Label

func update_points(new_points):
	point_text.text = "Points: " + str(new_points)

func update_combo(new_percentage, number):
	combo_bar.value = new_percentage
	combo_label.text = "Combo" if number == 0 else "Combo : " + str(number)
