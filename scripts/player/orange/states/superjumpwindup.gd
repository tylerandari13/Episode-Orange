extends OrangeState

var jump_time = 0.5

var cur_time

# Called when the state machine enters this state.
func on_enter():
	owner.sprite.play("superjumpwindup")
	cur_time = 0


# Called every frame when this state is active.
func on_process(delta):
	if(cur_time < jump_time): cur_time += delta


# Called every physics frame when this state is active.
func on_physics_process(delta):
	if(Input.get_axis("left", "right") != 0): owner.velocity.x = Input.get_axis("left", "right") * owner.walk_speed / 3
	if(cur_time >= jump_time && owner.is_on_floor() && !Input.is_action_pressed("superjump")): change_state("none/superjump")


# Called when there is an input event while this state is active.
func on_input(event: InputEvent):
	pass


# Called when the state machine exits this state.
func on_exit():
	pass

