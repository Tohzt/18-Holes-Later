extends Node

@onready var Master: Entity = get_parent()

func _physics_process(_delta):
	_handle_movement_input()
	_handle_throw_input()

func _handle_throw_input():
	if Input.is_action_just_pressed("right_click"):
		Master.State_Controller.popup_state = "Throw"

func _handle_movement_input():
	if Input.is_action_just_pressed("ui_accept") and Master.is_on_floor():
		Master.velocity.y = Master.JUMP_FORCE
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		Master.velocity.x = direction.x * Master.SPEED
		Master.velocity.z = direction.z * Master.SPEED
	else:
		Master.velocity.x = move_toward(Master.velocity.x, 0, Master.SPEED)
		Master.velocity.z = move_toward(Master.velocity.z, 0, Master.SPEED)
