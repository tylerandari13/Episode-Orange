class_name Room
extends Area2D

@export var boundaries : CollisionShape2D

var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rooms")
	body_entered.connect(_body_entered)
	boundaries.modulate.a = 0

func update_enemy(enemy : Enemy):
	if(owner.player.current_room == self):
		enemy.enable()
	else:
		enemy.disable()

func update_enemies():
	for enemy in enemies:
		update_enemy(enemy)

func _body_entered(body : Node2D):
	if(body is Enemy):
		enemies.append(body)
		update_enemy(body)
	if(body is Player):
		body.update_room(self)
		update_enemies()
