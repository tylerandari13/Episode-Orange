extends CharacterBody2D

@export_category("Orange")
@export_group("Speed")
@export var speed : float = 400.0
@export var jump_velocity : float = -700.0

@export_group("Mach Speeds")
@export var mach1 : float = 0
@export var mach2 : float = 425

@export var grab_speed : float = 588

@export var mach3 : float = 750
@export var mach4 : float = 1000
@export var machtop : float = 1500

@export_group("Room")
@export var room : String
@export var spawn : String
@export var room_left : float
@export var room_right : float
@export var room_top : float
@export var room_bottom : float

@export_group("Misc")
@export var is_player : bool = true
@export var offscreen_time = 1

signal room_changed(old_room : String, new_room : String)

@onready var state_machine : FiniteStateMachine = $FiniteStateMachine
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var stand_collision : CollisionShape2D = $StandCollision
@onready var duck_collision : CollisionShape2D = $DuckCollision
@onready var camera : Camera2D = $Camera2D

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity") 
var mach : float = 0
var direction : float = 1
var cur_time : float = 0


func _ready():
	back_to_the_start()

func _physics_process(delta):
	if(!is_on_floor() && state_machine.current_state.use_gravity):
		velocity.y += gravity * delta

	sprite.flip_h = direction < 0

	if(!get_rooms().get(room).overlaps_body(self)):
		cur_time += delta
		if(cur_time >= offscreen_time):
			back_to_the_start()
			cur_time = 0
	else:
		cur_time = 0

	move_and_slide()

func back_to_the_start():
	if(!room.is_empty()):
		if(spawn.is_empty()):
			change_room(room, "main")
		else:
			change_room(room, spawn)

func get_rooms():
	var retarray = {}
	for _room in owner.get_children():
		if("is_room" in _room):
			retarray[_room.get_name()] = _room
	return retarray

func get_room(new_room : String):
	return get_rooms().get(new_room)

func get_room_collision(new_room : String):
	return get_room(new_room).collision_object

func get_room_rect(new_room : String):
	var retrect = get_room(new_room).collision_object.shape.get_rect()
	var guh = get_room_collision(new_room)
	retrect.position.x += guh.position.x
	retrect.position.y += guh.position.y
	return retrect

func set_ducking(ducking : bool):
	stand_collision.disabled = ducking
	duck_collision.disabled = !ducking

func get_mach(precise : bool = false, _mach = mach) -> float:
	if(precise):
		return _mach
	else:
		if(_mach < mach2):
			return 1
		if(_mach >= mach2 && _mach < mach3):
			return 2
		if(_mach >= mach3 && _mach < mach4):
			return 3
		if(_mach >= mach4):
			return 4
		return 0

func change_room(new_room : String, new_spawn : String):
	var colobj = get_room_collision(new_room)
	var collision : Rect2 = get_room_rect(new_room)
	camera.set_limit(SIDE_LEFT, collision.position.x)
	room_left = collision.position.x
	
	camera.set_limit(SIDE_RIGHT, collision.position.x + collision.size.x)
	room_right = collision.position.x + collision.size.x
	
	camera.set_limit(SIDE_TOP, collision.position.y)
	room_top = collision.position.y
	
	camera.set_limit(SIDE_BOTTOM, collision.position.y + collision.size.y)
	room_bottom = collision.position.y + collision.size.y

	var _spawn = get_room(room).get_node(new_spawn)
	if(_spawn):
		position = _spawn.position
	else:
		push_warning("You good bro? The room " + new_room + " doesnt seem to have a spawnpoint named " + new_spawn + ".")
	
	room = new_room
	spawn = new_spawn
