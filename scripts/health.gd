class_name Health
extends NodeOrange

signal killed

@export var max_health = 100

var alive = true

@onready var health = max_health

func damage(amount):
	health = max(health - amount, 0)
	if(health <= 0):
		alive = false
		killed.emit()

func heal(amount):
	health = min(health + amount, max_health)
	if(health > 0):
		alive = true
