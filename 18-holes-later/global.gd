extends Node

const DISC = preload("res://Objects/Disc/disc.tscn")
var Player : CharacterBody3D
var Scene : Node

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Scene = get_tree().root.get_child(1)

func _process(_delta):
	if !Player: 
		Player = get_tree().get_first_node_in_group("Player")
		if  Player:
			Scene = get_tree().root.get_child(1)
	else: return

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			#get_tree().get_first_node_in_group("PauseMenu").show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
		else:
			#get_tree().get_first_node_in_group("PauseMenu").hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("right_click"):
		var disc = DISC.instantiate()
		disc.position = Player.Hand.global_position
		disc.power = Player.MAX_POWER/2
		disc.target_dir = Player.get_node("SpringArm3D").get_node("Camera3D").get_global_transform().basis.z
		disc.target_dir.y -= deg_to_rad(20)
		Scene.add_child(disc)
