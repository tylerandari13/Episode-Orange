class_name Orange
extends Player

@export var jump_velocity = -700
@export_group("Speed")
@export var walk_speed = 500
@export var grab_speed = 750
@export var mach3 = 1500
@export var acceleration = 15

var mach_speed = 0

func physics_process(delta):
	if(Input.is_action_just_pressed("grab") && state_machine.current_state.can_grab):
		if(Input.is_action_pressed("superjump") || Input.is_action_pressed("up")):
			state_machine.change_state("none/uppercut")
		else:
			state_machine.change_state("none/grab")
	if(Input.is_action_just_pressed("taunt") && state_machine.current_state.can_taunt): state_machine.change_state("none/taunt")
	if(Input.is_action_just_pressed("jump") && state_machine.current_state.can_jump && is_on_floor()): jump()
	
	if(is_on_wall_only() && state_machine.current_state.can_wallrun): state_machine.change_state("none/wallrun")

func jump(): velocity.y = jump_velocity

func get_mach_speed(speed = mach_speed):
	if(speed < mach3 / 2): return 1
	if(speed < mach3): return 2
	if(speed < mach3 * 4): return 3
	return 4
