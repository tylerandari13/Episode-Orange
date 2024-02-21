class_name Collectible
extends StaticBody2D

@export_category("Collectible")
@export var worth = 0
@export var respawn_during_escape = false
@export var sprite : Node2D
@export var amount_text : Label
@export var collision : Node2D

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("collectibles")
	if(respawn_during_escape): add_to_group("escape_spawn")
	#body_entered.connect(try_collect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(amount_text != null && collected): amount_text.position.y -= 5


func try_collect(player):
	if(player is Player && !collected):
		if(sprite != null): sprite.modulate.a = 0.5 if player.current_room.is_secret else 0
		player.add_points(worth)
		player.add_combo(worth)
		collected = true
		if(collision != null): collision.visible = false
		if(amount_text != null):
			amount_text.position = Vector2()
			amount_text.visible = true
			amount_text.text = str(worth)
		if(!respawn_during_escape && !player.current_room.is_secret):
			collision_layer = 0
			await get_tree().create_timer(5).timeout
			queue_free()

		_on_collected(player)

func try_respawn():
	if(sprite != null): sprite.modulate.a = 1
	collected = false
	if(collision != null): collision.visible = true
	_on_respawn()

func _on_collected(player): pass
func _on_respawn(): pass
