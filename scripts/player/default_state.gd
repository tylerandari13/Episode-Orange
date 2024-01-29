class_name DefaultState
extends StateMachineState

@export var default_state : StateMachineState

# Called when the state machine enters this state.
func on_enter():
	state_machine.set_current_state(default_state)

