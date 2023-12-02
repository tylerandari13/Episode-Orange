class_name CollectibleBase
extends PlayerTrigger

@export var number_text : Label
@export var points = 0

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var alpha = sprite.modulate.a
@onready var origin_y = number_text.position.y

var collected = false

var texturepath : Dictionary
func set_textures(): return Array()

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	number_text.visible = false

	Globals.add_collectible(self)

	if(set_textures().size() < 1): return
	if(set_textures().size() < 2):
		texturepath = set_textures()[0]
	else:
		texturepath = set_textures()[randi() % set_textures().size()]

	sprite.set_sprite_frames(load(texturepath.path))
	if(randi() % 2 == 0):
		sprite.play("default")
	else:
		sprite.play_backwards("default")

	if(texturepath.hues.size() < 1): return
	sprite.set_material(sprite.get_material().duplicate(true))
#	sprite.material.set_shader_parameter("Shift_Hue", texturepath.hues[randi() % texturepath.hues.size()])
	sprite.material.set_shader_parameter("Shift_Hue", randi_range(0, 10) * 0.1)

func collision_entered(player : CharacterBody2D):
	if(!collected):
		sprite.modulate.a = alpha * 0.5 if player.get_current_room().is_secret else 0
		collected = true
		number_text.text = str(points)
		number_text.visible = true
		player.add_points(points)
		on_collected(player)

func respawn():
	if(collected):
		sprite.modulate.a = alpha
		collected = false
		on_respawn()

func on_respawn(): pass

func on_collected(player : CharacterBody2D): pass

func _process(delta):
	if(collected):
		if(abs(number_text.position.y - origin_y) > 300):
			number_text.position.y = origin_y
			number_text.visible = false
		else:
			number_text.position.y -= 5
