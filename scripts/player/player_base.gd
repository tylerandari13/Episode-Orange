class_name Player
extends CharacterBody2D

@export var state_machine : FiniteStateMachine
@export var sprite : AnimatedSprite2D
@export var afterimage_container : Node2D
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

func _process(delta):
	if(state_machine.current_state.has_afterimage):
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

func _physics_process(delta):
	if(!is_on_floor() && state_machine.current_state.use_gravity): velocity.y += gravity * delta
	if(state_machine.current_state.use_friction): velocity.x = velocity.x * 0.7
	if(state_machine.current_state.decide_direction_based_on_velocity):
		if(velocity.x > 0):
			direction = 1
		if(velocity.x < 0):
			direction = -1

	sprite.flip_h = direction < 0

	move_and_slide()

	physics_process(delta)

func add_points(_points):
	points += _points
	_update_points(points)

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

func physics_process(delta): pass
func jump(): pass

func _on_transformation(transformation : String): pass
func _update_points(new_points): pass
func _update_combo(new_percentage): pass
