class_name Orange
extends Player

@export var jump_velocity = -700
@export_group("Speed")
@export var walk_speed = 500
@export var grab_speed = 750

func physics_process(delta):
	if(Input.is_action_just_pressed("grab") && state_machine.current_state.can_grab):
		if(Input.is_action_pressed("superjump") || Input.is_action_pressed("up")):
			state_machine.change_state("none/uppercut")
		else:
			state_machine.change_state("none/grab")
	if(Input.is_action_just_pressed("taunt") && state_machine.current_state.can_taunt):
		state_machine.change_state("none/taunt")

func jump(): velocity.y = jump_velocity
