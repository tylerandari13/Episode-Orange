class_name WalkingEnemy
extends Enemy

@export_category("Walking Enemy")
@export var speed = 200

func walk_process(delta):
	velocity.x = speed * direction
	if(is_on_wall()): direction = get_wall_normal().x
