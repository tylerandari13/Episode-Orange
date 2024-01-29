extends Player

@export var walk_speed = 500
@export var jump_velocity = -700
@export var spin_time = 0.5

var spinning = false
var current_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(spinning):
		if(current_time < spin_time):
			current_time += delta * (0.5 if Input.is_action_pressed("grab") else 1)
		else:
			spinning = false

	if(Input.is_action_just_pressed("grab") && !spinning):
		spin()

func spin():
	current_time = 0
	spinning = true
	state_machine.current_state.spin()
