class_name Player
extends CharacterBody2D

@export var state_machine : FiniteStateMachine
@export var sprite : AnimatedSprite2D
@export var afterimage_container : Node2D
@export var camera : Camera2D
@export var UI : CanvasLayer
@export var raycast : ShapeCast2D
@export var afterimage_colors = [
	Color(1, 0, 0, 0.5),
	Color(0, 1, 0, 0.5)
]

var direction = 1
var afterimage_times = {}
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var afterimage_index = 0
var afterimage_process_index = 0
var points = 0
var combo = 0
var combo_number = 0
var current_room : Room
var secrets = {}
var respawn_pos : Vector2

func _ready():
	state_machine.state_changed.connect(_on_state_changed)
	if(owner is Level): owner.set_player(self)

func _process(delta):
	if(has_afterimage()):
		if(afterimage_process_index % 10 == 0):
			add_afterimage()
	afterimage_process_index += 1
	for node in afterimage_times:
		if(afterimage_times[node].time_left <= 0):
			afterimage_container.get_node(node).queue_free()
			afterimage_times[node].time_left = INF
		elif(is_finite(afterimage_times[node].time_left)):
			afterimage_times[node].time_left -= delta
			afterimage_container.get_node(node).global_position = afterimage_times[node].origin_pos
	if(Input.is_action_just_pressed("taunt") && can_taunt()): taunt()

	if(combo > 0):
		combo -= Global.apply_delta_time(0.25, delta)
		UI.update_combo(combo, combo_number)
	else:
		end_combo()

	raycast.target_position = velocity * 0.02

func _physics_process(delta):
	if(!is_on_floor() && use_gravity()): velocity.y += gravity * delta
	if(use_friction()): velocity.x = velocity.x * 0.7
	if(decide_direction_based_on_velocity()):
		if(velocity.x > 0):
			direction = 1
		if(velocity.x < 0):
			direction = -1

	sprite.flip_h = direction < 0

	for i in range(raycast.get_collision_count()):
		var collider = raycast.get_collider(i)
		if(collider is Block):
			collider.touch(self)
		if(collider is Enemy):
			collider._on_player_collision(self)
		if(collider is Collectible):
			collider.try_collect(self)

	move_and_slide()

var debughue = 0
func _input(event):
	if(event.is_pressed() && event.as_text() == "F11" && has_node("HueShift")):
		debughue += 0.1
		$HueShift.set_hue(debughue)

# combo sillies
func increment_combo(inc = 1):
	combo_number += inc
	add_combo(100, true)

func add_combo(percent, forced = false):
	if((!forced && combo > 0) || forced):
		combo = min(combo + percent, 100)

func end_combo(give_points = true):
	if(give_points):
		add_points(combo_number ** 2 * 10)
	combo_number = 0
	UI.update_combo(combo, combo_number)

func add_points(_points):
	points += _points
	UI.update_points(points)

func add_afterimage(color = Color(Color(), NAN)):
	if(is_nan(color.a)):
		color = afterimage_colors[afterimage_index % len(afterimage_colors)]
		afterimage_index += 1

	var afterimage = AnimatedSprite2D.new()
	afterimage.sprite_frames = sprite.sprite_frames
	afterimage.flip_h = sprite.flip_h
	afterimage.flip_v = sprite.flip_v
	afterimage.modulate = color
	#afterimage.z_index = -1

	afterimage_container.add_child(afterimage)
	afterimage.play(sprite.animation, 0)
	afterimage.set_frame_and_progress(sprite.frame, sprite.frame_progress)

	afterimage_times[afterimage.name] = {
		time_left = 0.7,
		origin_pos = afterimage.global_position
	}

func update_room(room : Room):
	respawn_pos = position
	current_room = room
	update_camera_bounds(room.boundaries)

func room_respawn():
	position = respawn_pos

func update_camera_bounds(bound_object : CollisionShape2D):
	var pos = bound_object.global_position
	var offset = bound_object.shape.get_rect().size / 2
	camera.set_limit(SIDE_TOP, pos.y - offset.y)
	camera.set_limit(SIDE_BOTTOM, pos.y + offset.y)
	camera.set_limit(SIDE_LEFT, pos.x - offset.x)
	camera.set_limit(SIDE_RIGHT, pos.x + offset.x)

func reset_camera_bounds():
	camera.set_limit(SIDE_TOP, -10000000)
	camera.set_limit(SIDE_BOTTOM, 10000000)
	camera.set_limit(SIDE_LEFT, -10000000)
	camera.set_limit(SIDE_RIGHT, 10000000)

func enter_secret(spawn : Secret):
	global_position = spawn.global_position
	velocity.y = -1000

func add_secret(secret : Room):
	secrets[secret.get_path()] = secret
	UI.secret_entered(len(secrets), len(get_tree().get_nodes_in_group("secrets")))


# overwriteable in case someone wants to make a character with a different state machine or no state machine at all
func has_afterimage() -> bool: return state_machine.current_state.has_afterimage
func can_taunt() -> bool: return state_machine.current_state.can_taunt
func use_gravity() -> bool: return state_machine.current_state.use_gravity
func use_friction() -> bool: return state_machine.current_state.use_friction
func decide_direction_based_on_velocity() -> bool: return state_machine.current_state.decide_direction_based_on_velocity

func get_block_damage() -> int: return state_machine.current_state.block_damage

func get_enemy_collision_mode() -> int: return state_machine.current_state.enemy_collision_mode
func get_collision_damage() -> float: return state_machine.current_state.enemy_damage

# some scripts might try to make the player move externally, in case your character cant jump or taunt these are here so it just does nothing
func jump(): pass
func taunt(): pass

# player specific overwriteable functions
func _on_transformation(transformation : String): pass
func _enemy_touched(enemy) -> bool: return true
func _on_state_changed(new_state : StateMachineState): pass
