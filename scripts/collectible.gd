class_name CollectibleBase
extends PlayerTrigger

var alpha = modulate.a
var collected = false

var texturepaths : Array
func set_texturepaths(): return Array()

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if(texturepaths.size() < 1): return
	var sprite = null
	for child in get_children():
		if(child is Sprite2D):
			sprite = child
			break
	if(sprite):
		sprite.texture = load(texturepaths[randi() % texturepaths.size()])

func collision_entered(player : CharacterBody2D):
	if(!collected):
		modulate.a = alpha * 0.5 if player.get_current_room().is_secret else 0
		collected = true
		on_collected(player)

func respawn():
	if(collected):
		modulate.a = alpha
		collected = false
		on_respawn()

func on_respawn(): pass

func on_collected(player : CharacterBody2D): pass
