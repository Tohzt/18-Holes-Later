class_name Launcher_Class
extends Node3D

@onready var Cam_Focus = $"Barrel Pivot/CamFocus"
@onready var Barrel_Pivot = $"Barrel Pivot"
@onready var Input_Controller: InputController = $InputController

var accepts_input = false
var can_look = true
var can_shoot = true
var did_shoot = false
var new_dir := Vector3.ZERO

func _ready():
	set_active(false)
	
func _process(_delta):
	if !accepts_input: return
	
	new_dir.y = Input_Controller.rot_cam.y
	
	Barrel_Pivot.rotation.y = new_dir.y
	
	if did_shoot:
		did_shoot = false
		print("FIRE!")

func set_active(TorF: bool):
	if TorF:
		accepts_input = true
		can_look = true
		can_shoot = true
		Input_Controller.launcher_action = true
		Input_Controller.launcher_look = true
	else:
		accepts_input = false
		can_look = false
		can_shoot = false
		Input_Controller.launcher_action = false
		Input_Controller.launcher_look = false
		
