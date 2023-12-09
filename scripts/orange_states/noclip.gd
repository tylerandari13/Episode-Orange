extends OrangeState

# Called when the state machine enters this state.
func on_enter():
	owner.stand_collision.disabled = true
	owner.duck_collision.disabled = true
	owner.sprite.play("noclip")


# Called every frame when this state is active.
func on_process(delta):
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta):
	var x_direction = 0
	var y_direction = 0
	if(Input.is_action_pressed("left")):
		x_direction -= 1
	if(Input.is_action_pressed("right")):
		x_direction += 1
	if(Input.is_action_pressed("up")):
		y_direction -= 1
	if(Input.is_action_pressed("down")):
		y_direction += 1
	owner.velocity = Vector2(x_direction * owner.speed, y_direction * owner.speed)


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	owner.stand_collision.disabled = false
	owner.duck_collision.disabled = false
	owner.sprite.play("default")

