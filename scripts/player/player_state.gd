class_name PlayerState
extends StateMachineState

@export_category("Player State")
@export var use_gravity = true
@export var use_friction = true
@export var decide_direction_based_on_velocity = true
@export var has_afterimage = false
@export var can_taunt = true
@export var block_damage = 0
@export_group("Enemy Interaction")
@export_enum("Pass Through", "Bump", "Damage", "Grab") var enemy_collision_mode : int # Grab for convenience.
@export var enemy_damage = 1.0
