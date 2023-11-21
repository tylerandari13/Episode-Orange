class_name Player
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
@export var camera : Camera2D

signal room_changed(new_room : String, new_spawn : String)

@onready var state_machine : FiniteStateMachine = $FiniteStateMachine
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var stand_collision : CollisionShape2D = $StandCollision
@onready var duck_collision : CollisionShape2D = $DuckCollision
@onready var remote_transform : RemoteTransform2D = $RemoteTransform2D
@onready var duck_checker: Area2D = $DuckCheck

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity") 
var mach : float = 0
var direction : float = 1
var cur_time : float = 0
var disabled : bool = false

func _ready():
	back_to_the_start()

func _process(delta):
	if(get_room(room) && !get_room(room).overlaps_body(self)):
		cur_time += delta
		remote_transform.remote_path = NodePath()
		if(cur_time >= offscreen_time):
			back_to_the_start()
			cur_time = 0
	else:
		cur_time = 0
		remote_transform.remote_path = camera.get_path()

func _physics_process(delta):
	if(!is_on_floor() && state_machine.current_state.use_gravity):
		velocity.y += gravity * delta

	sprite.flip_h = direction < 0

	if(!disabled):
		move_and_slide()

func back_to_the_start():
	if(!room.is_empty()):
		if(spawn.is_empty()):
			change_room(room, "main")
		else:
			change_room(room, spawn)

func find_level_in_root():
	for child in get_tree().root.get_children():
		if(child is Level):
			return child

func get_room(new_room : String):
	var level = find_level_in_root()
	if(level):
		var room = find_level_in_root().get_node(new_room)
		if(!room):
			var room_holder = find_level_in_root().get_node("rooms")
			if(room_holder):
				room = room_holder.get_node(new_room)
		return room

func get_current_room():
	return get_room(room)

func set_ducking(ducking : bool):
	stand_collision.disabled = ducking
	duck_checker.visible = ducking

func can_stand():
	var colarray = duck_checker.get_overlapping_bodies()
	var cant = false
	for collision in colarray:
		if(!collision is CollisionObject2D):
			cant = true
	return !cant

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

func try_grab():
	if(Input.is_action_pressed("up")):
		state_machine.change_state("Uppercut")
	else:
		state_machine.change_state("Grab")

func change_room(new_room : String, new_spawn : String):
	var colobj = get_room(new_room).get_collision()
	var collision : Rect2 = get_room(new_room).get_rect()
	camera.set_limit(SIDE_LEFT, collision.position.x)
	room_left = collision.position.x
	
	camera.set_limit(SIDE_RIGHT, collision.position.x + collision.size.x)
	room_right = collision.position.x + collision.size.x
	
	camera.set_limit(SIDE_TOP, collision.position.y)
	room_top = collision.position.y
	
	camera.set_limit(SIDE_BOTTOM, collision.position.y + collision.size.y)
	room_bottom = collision.position.y + collision.size.y

	var _spawn = get_room(new_room).get_spawnpoint(new_spawn)
	if(_spawn):
		position = _spawn.position
	else:
		push_warning("You good bro? The room " + new_room + " doesnt seem to have a spawnpoint named " + new_spawn + ".")
	
	room = new_room
	spawn = new_spawn
	room_changed.emit(new_room, new_spawn)
