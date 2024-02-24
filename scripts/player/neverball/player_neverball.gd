class_name Neverball
extends Player

var breaking = false
var is_ducking = false

@onready var ball = $RigidBody2D
@onready var rigid_collision = $RigidBody2D/CollisionShape2D
@onready var player_collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	raycast.add_exception(ball)
	ball.angular_velocity = randi_range(-5, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

	raycast.target_position = ball.linear_velocity * 0.05

	breaking = Input.is_action_pressed("run")

	camera.rotation = Input.get_axis("right", "left") * (0.25 if Input.get_axis("up", "down") == 0 else 0.1)

	if(Input.is_action_just_pressed("down")): set_ducking(true)
	if(Input.is_action_just_released("down")): set_ducking(false)

func _integrate_forces(state : PhysicsDirectBodyState2D):
	global_position = ball.global_position
	ball.position = Vector2()

	if(state_machine.current_state.integrate_forces(state)):
		state.linear_velocity += Global.apply_delta_time(Vector2.from_angle(camera.rotation + deg_to_rad(90)) * (gravity * 0.05 * ball.gravity_scale) * (0.5 if is_ducking else 1), state.step)

		if(Input.is_action_just_pressed("jump")):
			state.linear_velocity += Vector2.from_angle(camera.rotation - deg_to_rad(90)) * 1000 * (0.5 if is_ducking else 1)

func set_ducking(ducking):
	is_ducking = ducking
	rigid_collision.scale = Vector2(1, 1) * (0.5 if ducking else 1)
	player_collision.scale = Vector2(0.9, 0.9) * (0.5 if ducking else 1)
	raycast.scale = rigid_collision.scale
	sprite.scale = rigid_collision.scale

func has_afterimage() -> bool: return get_mach_speed() > 2

func get_mach_speed(speed = ball.linear_velocity.length()): return super(speed)

func get_block_damage() -> int: return get_mach_speed()

func get_enemy_collision_mode() -> int:
	match get_mach_speed():
		0, 1:
			return 0
		2:
			return 1
	return 2

func get_collision_damage() -> float: return get_mach_speed() - 2
