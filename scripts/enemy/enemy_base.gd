class_name Enemy
extends CharacterBody2D

@export var health : Health
@export var stun_time = 5
@export var grabbable = true
@export var gets_scared = true
@export var counts_toward_combo = true
@export var supertauntable = true
@export var use_gravity = true
@export var use_friction = true
@export_group("Sprites and Player Collision")
@export var sprite : AnimatedSprite2D
@export var collision : CollisionShape2D

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stunned = false
var current_time = 0
var room = null
var combo_amount = 100

@onready var origin_pos = position

func _ready():
	add_to_group("enemies")

func _process(delta):
	if(stunned):
		if(current_time < stun_time):
			current_time += delta
		else:
			stunned = false

func _physics_process(delta):
	if(!is_on_floor() && use_gravity):
		velocity.y += gravity * delta
	elif(use_friction): velocity.x = velocity.x * 0.9
	sprite.flip_h = true if direction > 0 else false
	if(health.get_health() > 0 && !stunned): walk_process(delta)
	move_and_slide()

func _on_player_collision(player : Node2D):
	if(player is Player && health.get_health() > 0 && player._enemy_touched(self)):
		if(player.get_enemy_collision_mode() == 1 && stun(player)):
			current_time = 0
			stunned = true
			velocity = Vector2(player.velocity.x * 2, -100)
			player.add_combo(combo_amount)
			combo_amount = combo_amount * 0.5
		elif(player.get_enemy_collision_mode() == 2 && damage(player, player.get_collision_damage())):
			health.damage(player.get_collision_damage())
			velocity = Vector2(player.velocity.x, player.velocity.abs().x * -0.5)
			if(counts_toward_combo):
				player.increment_combo()
			else:
				player.add_combo(100)
	elif(health.get_health() <= 0):
		collision.visible = false
		collision_mask = 0

func disable():
	visible = false
	position = origin_pos
	set_process_mode(Node.PROCESS_MODE_DISABLED)
func enable():
	visible = true
	set_process_mode(Node.PROCESS_MODE_INHERIT)
func set_room(_room): room = _room

func walk_process(delta): pass # for walking enemies, dont touch

func stun(player): return true
func damage(player, amount): return true
