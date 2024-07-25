extends Node

@onready var Master: Entity = get_parent()

func _physics_process(_delta):

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and Master.is_on_floor():
		Master.velocity.y = Master.JUMP_FORCE

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		Master.velocity.x = direction.x * Master.SPEED
		Master.velocity.z = direction.z * Master.SPEED
	else:
		Master.velocity.x = move_toward(Master.velocity.x, 0, Master.SPEED)
		Master.velocity.z = move_toward(Master.velocity.z, 0, Master.SPEED)
