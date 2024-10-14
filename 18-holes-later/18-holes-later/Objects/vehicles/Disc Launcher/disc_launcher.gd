class_name Launcher_Class
extends Node3D

@onready var Cam_Mount = $Cam_Mount
@onready var Barrel_Pivot = $"Barrel Pivot"
@onready var Barrel_Exit = $"Barrel Pivot/Barrel Exit"
@onready var Barrel_Dir: RayCast3D = $"Barrel Pivot/RayCast3D"
@onready var Detect_Player = $"Detect Player"
@onready var Input_Controller: InputController = $InputController

var look_forward = true
var look_around = false
var accepts_input = false
var can_look = true
var can_shoot = true
var did_shoot = false
var new_dir := Vector3.ZERO
var input_look: Vector2

var ammo_type = "CharacterBody3D"
var ammo_char = preload("res://Objects/Discs/Disc_CharBod/disc_charbod.tscn")
var ammo_rig  = preload("res://Objects/Discs/Disc_RigBod/disc_rigidbod.tscn")

func _ready():
	set_active(false)
	
func _process(_delta):
	if !accepts_input: 
		input_look = Input_Controller.input_look
		var overlap = Detect_Player.get_overlapping_bodies()
		if overlap: _detect(overlap)
		return
	
	
	new_dir.y = Input_Controller.input_look.y
	Barrel_Pivot.rotation.y = new_dir.y
	
	if did_shoot:
		did_shoot = false
		throw_disc()

func _detect(overlap):
	for body in overlap:
		if body.is_in_group("Character"):
			if body.did_interact:
				if !accepts_input:
					set_active(true)
					Global.Player.set_active(false)
					Global.Cameraman.set_target(self, Cam_Mount)

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

func toggle_type():
	if ammo_type == "CharacterBody3D":
		ammo_type = "RigidBody3D"
	else:
		ammo_type = "CharacterBody3D"

func throw_disc():
	var ammo
	if ammo_type == "CharacterBody3D": ammo = ammo_char.instantiate() 
	else: ammo = ammo_rig.instantiate()
	
	ammo.position = Barrel_Exit.global_position
	ammo.target_dir = Barrel_Dir.global_transform.basis * -Barrel_Dir.target_position.normalized()
	ammo.power = 10
	ammo.in_bag = false
	ammo.in_hand = false
	ammo.visible = true
	#disc.target_dir.y -= deg_to_rad(20)
	ammo.launch = true
	get_tree().root.add_child(ammo)
