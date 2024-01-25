class_name Enemy
extends CharacterBody2D

@export var health = 1.0
@export var grabbable = true
@export var gets_scared = true
@export var counts_toward_combo = true
@export var supertauntable = true
@export var use_gravity = true
@export var use_friction = true
@export_group("Sprites and Player Collision")
@export var sprite : AnimatedSprite2D
@export var player_detection : Area2D
@export var collision : CollisionShape2D

var direction = -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player_detection.body_entered.connect(_on_player_collision)

func _physics_process(delta):
	if(!is_on_floor() && use_gravity):
		velocity.y += gravity * delta
	elif(use_friction): velocity.x = velocity.x * 0.9
	sprite.flip_h = true if direction > 0 else false
	if(health > 0): walk_process(delta)
	physics_process(delta)
	move_and_slide()

func _on_player_collision(player : Node2D):
	if(player is Player && player._enemy_touched(self)):
		if(player.get_enemy_collision_mode() == 1 && stun(player)):
			velocity = Vector2(player.velocity.x * 2, -100)
		elif(player.get_enemy_collision_mode() == 2 && damage(player, player.get_collision_damage())):
			health -= player.get_collision_damage()
			velocity = Vector2(player.velocity.x, player.velocity.abs().x * -0.5)
			if(counts_toward_combo):
				player.increment_combo()
			else:
				player.add_combo(100)
			if(health <= 0):
				collision.visible = false
				collision_mask = 0
#		else: print(player.get_enemy_collision_mode())

func physics_process(delta): pass
func walk_process(delta): pass # for walking enemies, dont touch
func stun(player): return true
func damage(player, amount): return true
