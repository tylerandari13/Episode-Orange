class_name Health
extends NodeOrange

signal killed

@export var max_health = 1.0
#@export_enum("off", "auto", "on") var regenerate_health = 1

var alive = true

@onready var health = max_health

func damage(amount):
	health = max(health - amount, 0)
	if(health <= 0 && alive):
		alive = false
		killed.emit()

func heal(amount):
	health = min(health + amount, max_health)
	if(health > 0 && !alive):
		alive = true

func get_health(): return health
func set_health(amount): health = max(min(amount, max_health), 0)
