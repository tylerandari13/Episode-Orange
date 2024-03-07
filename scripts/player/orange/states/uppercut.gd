extends OrangeState

var move_velocity = 30

# Called when the state machine enters this state.
func on_enter():
	owner.velocity.y = owner.jump_velocity * 1.5 if owner.is_on_floor() else owner.jump_velocity
	owner.sprite.play("uppercut")


# Called every frame when this state is active.
func on_process(delta):
	if(owner.is_on_floor() && owner.velocity.y >= 0): change_state("none/ground")
	enemy_collision_mode = EnemyCollisionMode.DAMAGE if owner.velocity.y < 0 else EnemyCollisionMode.PASSTHROUGH
	has_afterimage = owner.velocity.y < 0


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.is_action_pressed("left") && owner.velocity.x > owner.walk_speed * -1): owner.velocity.x -= move_velocity
	if(Input.is_action_pressed("right") && owner.velocity.x < owner.walk_speed): owner.velocity.x += move_velocity


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

