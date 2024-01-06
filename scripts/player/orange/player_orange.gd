class_name Orange
extends Player

@export_group("Speed")
@export var walk_speed = 500
@export var jump_velocity = -700
@export var grab_speed = 750
@export var mach3 = 1500
@export var acceleration = 15
@export var friction = 0.93

@export_group("Sprites and Collision")
@export var stand_collision : CollisionShape2D
@export var duck_collision : CollisionShape2D
@export var duck_area : Area2D

var mach_speed = 0

func _ready(): state_machine.state_changed.connect(_on_state_changed)

func physics_process(delta):
	if(Input.is_action_just_pressed("grab") && state_machine.current_state.can_grab):
		if(Input.is_action_pressed("superjump") || Input.is_action_pressed("up")):
			state_machine.change_state("none/uppercut")
		else:
			state_machine.change_state("none/grab")
	if(Input.is_action_just_pressed("taunt") && state_machine.current_state.can_taunt): state_machine.change_state("none/taunt")
	if(Input.is_action_pressed("jump") && state_machine.current_state.can_jump && is_on_floor()): jump()
	if(Input.is_action_pressed("down") && state_machine.current_state.can_dive): if(is_on_floor()):
		state_machine.change_state("none/roll")
	else:
		state_machine.change_state("none/dive")
	
	if(is_on_wall_only() && state_machine.current_state.can_wallrun): state_machine.change_state("none/wallrun")


func _on_state_changed(new_state : StateMachineState):
	set_ducking(new_state.ducking)


func get_mach_speed(speed = mach_speed):
	if(speed < mach3 / 2): return 1
	if(speed < mach3): return 2
	if(speed < mach3 * 2): return 3
	return 4

func set_ducking(ducking):
	stand_collision.visible = !ducking
	duck_collision.visible = ducking
	stand_collision.disabled = ducking
	duck_collision.disabled = !ducking
	duck_area.visible = ducking


func can_unduck() -> bool:
	for body in duck_area.get_overlapping_bodies():
		if(body != self):
			return false
	return true


func jump(): velocity.y = jump_velocity
