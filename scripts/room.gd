class_name Room
extends Area2D

@export var boundaries : CollisionShape2D
@export var respawn_if_fall = false
@export_group("Secret Area")
@export var is_secret = false

var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rooms")
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)
	boundaries.modulate.a = 0
	if(is_secret):
		owner.add_secret()
		add_to_group("secrets")

func _process(delta):
	pass

func update_enemies():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if(enemy.room == self):
			enemy.enable()
		else:
			enemy.disable()

func _body_entered(body : Node2D):
	if(body is Enemy && body.room == null):
		enemies.append(body)
		body.set_room(self)
	if(body is Player):
		body.update_room(self)
		owner.toggle_background(self)
		if(is_secret): body.add_secret(self)
		update_enemies()

func _body_exited(body : Node2D):
	if(body is Player && respawn_if_fall):
		body.room_respawn()
