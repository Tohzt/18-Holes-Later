class_name Entity_Character
extends Entity

@onready var Spring_Arm = $SpringArm3D
@onready var Camera = $SpringArm3D/Camera3D
@onready var Hand = $Hand

var game_disc_index: int = 0
var bag_of_discs: Array = [
	["Starter", "Driver", 2,2,-2,2],
	["Starter", "Hybrid", 1,1,-1,1],
	["Starter", "Putter", 0,0, 0,0]]

const MAX_POWER = 20

var is_throwing = false

func _ready():
	Global.Player = self
	super._ready()

# TODO: This should't be here
func _physics_process(delta):
	super._physics_process(delta)

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var angle_limit_down = 80
			var angle_limit_up = 20
			Spring_Arm.rotation.x = clampf(Spring_Arm.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			
			if State_Controller.state_suffix != "_Charge": 
				Spring_Arm.rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
				look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
