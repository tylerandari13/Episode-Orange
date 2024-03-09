class_name PlayerState
extends StateMachineState

enum EnemyCollisionMode {
	PASSTHROUGH,
	BUMP,
	DAMAGE
}

enum SpriteRotationMode {
	OFF,
	AUTO_FLOOR,
	AUTO_WALL,
	ON_FLOOR,
	ON_WALL,
	IGNORE
}

@export_category("Player State")
@export var use_gravity = true
@export var use_friction = true
@export var decide_direction_based_on_velocity = true
@export var has_afterimage = false
@export var can_taunt = true
@export var block_damage = 0
@export var sprite_rotation_mode : SpriteRotationMode
@export var sprite_rotation_offset = 90.0
@export_group("Enemy Interaction")
@export var enemy_collision_mode : EnemyCollisionMode
@export var enemy_damage = 1.0
