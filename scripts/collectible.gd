class_name CollectibleBase
extends PlayerTrigger

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var alpha = sprite.modulate.a

var collected = false

var texturepaths : Array
func set_texturepaths(): return Array()

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	texturepaths = set_texturepaths()
	if(texturepaths.size() < 1): return

	sprite.set_sprite_frames(load(texturepaths[randi() % texturepaths.size()]))
	sprite.play("default")

func collision_entered(player : CharacterBody2D):
	if(!collected):
		sprite.modulate.a = alpha * 0.5 if player.get_current_room().is_secret else 0
		collected = true
		on_collected(player)

func respawn():
	if(collected):
		sprite.modulate.a = alpha
		collected = false
		on_respawn()

func on_respawn(): pass

func on_collected(player : CharacterBody2D): pass
