class_name Collectible
extends Area2D

@export_category("Collectible")
@export var worth = 0
@export var respawn_during_escape = false
@export var amount_text : Label

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(try_collect)
	ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(amount_text != null): if(collected && position.y - amount_text.position.y < 256):
		amount_text.position.y += 1
	else:
		pass
		#amount_text.visible = false

func try_collect(body):
	if(body is Player && !collected):
		# modulate.a = 0.5 if body.current_room.is_secret else 0
		# body.add_points(worth)
		modulate.a = 0
		collected = true
		if(amount_text != null):
			print(position.y - amount_text.position.y)
			#amount_text.position = Vector2()
			amount_text.visible = true
			amount_text.text = str(worth)
			
		_on_collected(body)

func try_respawn():
	modulate.a = 1
	collected = false
	_on_respawn()

func ready(): pass
func _on_collected(player): pass
func _on_respawn(): pass
