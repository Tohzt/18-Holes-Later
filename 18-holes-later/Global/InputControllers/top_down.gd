extends Perspective

@onready var Master: Entity = get_parent().get_parent()

func init():
	Master.Spring_Arm.reparent(Master.Cam2_Pos)

func handle_input(_delta):
	_handle_camera_movement()
	_handle_movement_input()
	_handle_throw_input()
	
	if Input.is_action_just_pressed("tab"):
		Input_Controller.input = Input_Controller.THIRD_PERSON
		# TODO: Get camera better
		Global.Active_Camera = Master.Spring_Arm.get_node("Camera3D")

func _handle_camera_movement():
	Global.Active_Camera.position.x = Master.position.x
	Global.Active_Camera.position.z = Master.position.z

func _handle_throw_input():
	if Input.is_action_just_pressed("right_click"):
		Master.State_Controller.popup_state = "Throw"

func _handle_movement_input():
	if Input.is_action_just_pressed("ui_accept") and Master.is_on_floor():
		Master.velocity.y = Master.JUMP_FORCE
		
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = input_dir.normalized()#(Master.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		Master.velocity.x = direction.x * Master.SPEED
		Master.velocity.z = direction.y * Master.SPEED
	else:
		Master.velocity.x = move_toward(Master.velocity.x, 0, Master.SPEED)
		Master.velocity.z = move_toward(Master.velocity.z, 0, Master.SPEED)
