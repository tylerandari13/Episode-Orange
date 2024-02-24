class_name Orange
extends Player

@export_group("Speed")
@export var jump_velocity = -700
@export var grab_speed = 750
@export var acceleration = 15
@export var friction = 0.93

@export_group("Sprites and Collision")
@export var taunt_sprite : Sprite2D
@export var stand_collision : CollisionShape2D
@export var duck_collision : CollisionShape2D
@export var duck_area : Area2D
@export var stand_cast : ShapeCast2D
@export var duck_cast : ShapeCast2D

func _physics_process(delta):
	super(delta)
	if(Input.is_action_just_pressed("grab") && state_machine.current_state.can_grab):
		if(Input.is_action_pressed("superjump") || Input.is_action_pressed("up")):
			state_machine.change_state("none/uppercut")
		else:
			state_machine.change_state("none/grab")
	if(Input.is_action_pressed("jump") && state_machine.current_state.can_jump && is_on_floor()): jump()
	if(Input.is_action_pressed("down") && state_machine.current_state.can_dive): if(is_on_floor()):
		state_machine.change_state("none/roll")
	else:
		state_machine.change_state("none/dive")
	
	if(state_machine.current_state.can_wallrun && is_on_wall_only() && get_wall_normal().x != direction):
		state_machine.change_state("none/wallrun")

func set_ducking(ducking):
	stand_collision.visible = !ducking
	duck_collision.visible = ducking
	stand_collision.disabled = ducking
	duck_area.visible = ducking

	stand_cast.visible = !ducking
	duck_cast.visible = ducking
	raycast = duck_cast if ducking else stand_cast


func can_unduck() -> bool:
	for body in duck_area.get_overlapping_bodies():
		if(body != self):
			return false
	return true


func jump(): velocity.y = jump_velocity

func taunt(): state_machine.change_state("none/taunt")

func _on_state_changed(new_state : StateMachineState):
	set_ducking(new_state.ducking)
