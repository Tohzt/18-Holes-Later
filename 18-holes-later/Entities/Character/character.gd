class_name Entity_Character
extends Entity
@onready var Spring_Arm = $SpringArm3D
@onready var Cam2_Pos = $Cam2Pos
@onready var Hand = $Hand

var game_disc_index: int = 0
var bag_of_discs: Array = [
	["Starter", "Driver", 2,2,-2,2],
	["Starter", "Hybrid", 1,1,-1,1],
	["Starter", "Putter", 0,0, 0,0]]

const MAX_POWER = 20

var is_throwing = false

func _ready():
	super._ready()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if InputController.input_type == "Third_Person":
		if is_throwing: 
			Spring_Arm.spring_length = 1.8
			Spring_Arm.position.x = -0.4
			Spring_Arm.position.y = 0.4
			return
		else:
			Spring_Arm.position.x = 0
			Spring_Arm.spring_length = 2.5
			Spring_Arm.position.y = 0.333
		
	
	move_and_slide()

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var angle_limit_down = 80
			var angle_limit_up = 20
			Spring_Arm.rotation.x = clampf(Spring_Arm.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			
			#if !is_throwing:
			#el
			if StateController.state_suffix != "_Charge": 
				Spring_Arm.rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
				rotate_y(deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY))
