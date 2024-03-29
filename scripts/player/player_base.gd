class_name Player
extends Entity


@export var state_machine : FiniteStateMachine
@export var afterimage_container : Node2D
@export var camera : Camera2D
@export var UI : CanvasLayer
@export var raycast : ShapeCast2D
@export var afterimage_colors : Array[Color] = [
	Color(1, 0, 0, 0.5),
	Color(0, 1, 0, 0.5)
]


var afterimage_times = {}
var afterimage_index = 0
var afterimage_process_index = 0

var stats = PlayerStats.new()

var current_room : Room
var respawn_pos : Vector2
var BGs = Array(DirAccess.get_files_at("res://addons/UniversalFade/Patterns/")).map(func(element : String): return element.split(".")[0])

var debughue = 0


func _ready():
	state_machine.state_changed.connect(_on_state_changed)
	if(is_instance_valid(Global.get_level())): Global.get_level().set_player(self)

func _process(delta):
	_afterimage_process(delta)
	_combo_process(delta)
	_time_process(delta)

func _physics_process(delta):
	super(delta)
	_character_process(delta)
	_raycast_process(delta)

	move_and_slide()

func _input(event):
	if(event.is_action_pressed("special") && has_node("HueShift")):
		debughue += 0.1
		$HueShift.set_hue(debughue)


# combo sillies
func increment_combo(inc = 1):
	stats.combo_number += inc
	add_combo(100, true)

func add_combo(percent, forced = false):
	if((!forced && stats.combo > 0) || forced):
		stats.combo = min(stats.combo + percent, 100)

func end_combo(give_points = true):
	if(give_points):
		add_points(stats.combo_number ** 2 * 10)
	stats.combo_number = 0
	UI.update_combo(stats.combo, stats.combo_number)

func add_points(_points):
	stats.points += _points
	UI.update_points(stats.points)

func add_afterimage(color = Color(Color(), NAN)):
	if(is_nan(color.a)):
		color = afterimage_colors[afterimage_index % len(afterimage_colors)]
		afterimage_index += 1

	var afterimage = AnimatedSprite2D.new()
	afterimage.sprite_frames = sprite.sprite_frames
	afterimage.flip_h = sprite.flip_h
	afterimage.flip_v = sprite.flip_v
	afterimage.transform = transform
	afterimage.modulate = color
	#afterimage.z_index = -1

	afterimage_container.add_child(afterimage)
	afterimage.play(sprite.animation, 0)
	afterimage.set_frame_and_progress(sprite.frame, sprite.frame_progress)

	afterimage_times[afterimage.name] = {
		time_left = 0.7,
		origin_trans = global_transform
	}

func update_room(room : Room):
	respawn_pos = position
	current_room = room
	update_camera_bounds(room.boundaries)

func room_transition(room : Room):
	var a = is_instance_valid(current_room)
	var b = [0.25, Color.BLACK, BGs.pick_random()]
	set_physics_process(false)
	set_process(false)
	if(a): await Fade.fade_out.callv(b).finished
	update_room(room)
	if(a): await Fade.fade_in.callv(b).finished
	set_physics_process(true)
	set_process(true)

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
	stats.secrets[secret.get_path()] = secret
	UI.secret_entered(len(stats.secrets), len(get_tree().get_nodes_in_group("stats.secrets")))

func enter_level(level : String):
	Global.set_storage("player-pos", global_position)
	Global.set_storage("last-hub-level", Global.get_storage("last-loaded-level"))
	Global.load_level(level)

func escape_sequence(time : int):
	stats.escaping = true
	stats.escape_time += time
	UI.start_escape(stats.escape_time)

func finish_level():
	Global.load_level(Global.get_storage("last-hub-level"), Global.get_storage("player-pos"))

# overwriteable in case someone wants to make a character with a different state machine or no state machine at all
func use_gravity() -> bool: return state_machine.current_state.use_gravity
func use_friction() -> bool: return state_machine.current_state.use_friction

func has_afterimage() -> bool: return state_machine.current_state.has_afterimage
func can_taunt() -> bool: return state_machine.current_state.can_taunt
func decide_direction_based_on_velocity() -> bool: return state_machine.current_state.decide_direction_based_on_velocity

func get_block_damage() -> int: return state_machine.current_state.block_damage

func get_sprite_rotation_mode() -> int: return state_machine.current_state.sprite_rotation_mode
func get_sprite_rotation_offset() -> float: return state_machine.current_state.sprite_rotation_offset

func get_enemy_collision_mode() -> int: return state_machine.current_state.enemy_collision_mode
func get_collision_damage() -> float: return state_machine.current_state.enemy_damage

# some scripts might try to make the player move externally, in case your character cant jump or taunt these are here so it just does nothing
func jump(): pass
func taunt(): pass

# player specific overwriteable functions
func _on_transformation(transformation : String): pass
func _on_state_changed(new_state : StateMachineState): pass


func _afterimage_process(delta):
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
			afterimage_container.get_node(node).global_transform = afterimage_times[node].origin_trans


func _combo_process(delta):
	if(stats.combo > 0):
		stats.combo -= Global.apply_delta_time(0.25, delta)
		UI.update_combo(stats.combo, stats.combo_number)
	else:
		end_combo()

func _time_process(delta):
	stats.escape_time -= delta if stats.escape_time > 0 else 0
	UI.update_escape(stats.escape_time)

func _character_process(delta):
	#if(!is_on_floor() && use_gravity()): velocity.y += gravity * delta
	#if(use_friction()): velocity.x = velocity.x * 0.7
	if(decide_direction_based_on_velocity()):
		if(velocity.x > 0):
			direction = 1
		if(velocity.x < 0):
			direction = -1
	if(Input.is_action_just_pressed("taunt") && can_taunt()): taunt()

	sprite.flip_h = direction < 0
	if(get_sprite_rotation_mode() != PlayerState.SpriteRotationMode.IGNORE):
		sprite.rotation = get_floor_normal().angle() + deg_to_rad(get_sprite_rotation_offset()) \
			if (get_sprite_rotation_mode() == PlayerState.SpriteRotationMode.ON_FLOOR \
			|| get_sprite_rotation_mode() == PlayerState.SpriteRotationMode.AUTO_FLOOR) \
			&& is_on_floor() \
			else get_wall_normal().angle() + deg_to_rad(get_sprite_rotation_offset()) \
			if (get_sprite_rotation_mode() == PlayerState.SpriteRotationMode.ON_WALL \
			|| get_sprite_rotation_mode() == PlayerState.SpriteRotationMode.AUTO_WALL) \
			&& is_on_wall() \
			else get_sprite_rotation_offset() - 90

func _raycast_process(delta):
	if(raycast.is_colliding()): for i in range(raycast.get_collision_count()):
		var collider = raycast.get_collider(i)
		if(collider is Collectible):
			collider.try_collect(self)
		elif(collider is Block):
			collider.touch(self)
		elif(collider is Enemy):
			collider._on_player_collision(self)
	raycast.target_position = get_real_velocity() * delta * 1.5

func _enemy_touched(enemy) -> bool: return true

