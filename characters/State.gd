extends Node

class_name State
@export var can_move : bool = true
@export var use_directions : bool = true
var character : CharacterBody2D
var next_state : State

func state_input(_event : InputEvent):
	pass

func state_process(_delta):
	pass

func on_enter():
	pass

func on_exit():
	pass
