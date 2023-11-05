extends Node

class_name StateMachine

@export var character : CharacterBody2D
@export var current_state : State
@export var previous_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			child.character = character

		elif(!(child is Node)):
			push_warning("You good bro? " + child.name + " isnt a State for StateMachine.")

func  _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func _input(event : InputEvent):
	current_state.state_input(event)

func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	if(new_state == null):
		push_warning("You good bro? The state was set to null. Make sure you set the @export variable correctly lmao.")

	previous_state = current_state
	current_state = new_state
	current_state.on_enter()
	
