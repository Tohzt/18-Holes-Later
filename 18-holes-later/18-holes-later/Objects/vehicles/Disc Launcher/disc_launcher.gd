class_name Launcher_Class
extends Node3D

@onready var Cam_Focus = $"Barrel Pivot/CamFocus"
@onready var Barrel_Pivot = $"Barrel Pivot"
@onready var Barrel_Exit = $"Barrel Pivot/Barrel Exit"
@onready var Barrel_Dir: RayCast3D = $"Barrel Pivot/RayCast3D"
@onready var Input_Controller: InputController = $InputController

var accepts_input = false
var can_look = true
var can_shoot = true
var did_shoot = false
var new_dir := Vector3.ZERO

var ammo_char = preload("res://Objects/Discs/Disc_CharBod/disc_charbod.tscn")
var ammo_rig  = preload("res://Objects/Discs/Disc_RigBod/disc_rigidbod.tscn")

func _ready():
	set_active(false)
	
func _process(_delta):
	if !accepts_input: return
	
	new_dir.y = Input_Controller.rot_cam.y
	
	Barrel_Pivot.rotation.y = new_dir.y
	
	if did_shoot:
		did_shoot = false
		throw_disc()
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
		
func throw_disc():
	var ammo: Disc = ammo_rig.instantiate()
	ammo.position = Barrel_Exit.global_position
	ammo.target_dir = Barrel_Dir.global_transform.basis * -Barrel_Dir.target_position.normalized()
	#ammo.target_dir = Barrel_Pivot.position.direction_to(Barrel_Exit.position)
	#ammo.target_dir = Global.Cameraman.Camera.get_global_transform().basis.z
	ammo.power = 10
	ammo.in_bag = false
	ammo.in_hand = false
	ammo.visible = true
	#disc.target_dir.y -= deg_to_rad(20)
	ammo.launch = true
	get_tree().root.add_child(ammo)
