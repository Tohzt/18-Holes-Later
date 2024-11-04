class_name Entity_Character
extends Entity

@onready var Collision_Mask: CollisionShape3D = $Character_Base
@onready var Area_Interact: Area3D = $Area_Interact
@onready var Cam_Mount = $Cam_Mount
@onready var Hand = $Hand
@onready var Bag = $Bag

const MAX_POWER = 10
var game_disc_index: int = 0

var cd_interact_dur := 0.5
var cd_interact := cd_interact_dur
var is_charging = false
var is_on_tee = false
var aim_stable = false
var prev_look_dir = look_dir

var in_vehicle: CharacterBody3D

var charge_power = 0.0
var charge_max = 100.0
var charge_rate = 75

# Trace Properties
var predict_trace = false
var predict_search = false
var predict_cd_max = 50
var predict_cd = 0

# Move to Entity?
@onready var Input_Array: Array[String]
var slide_thresh = 7.1

func _ready():
	super._ready()
	Global.Player = self
	Global.Cameraman.set_target(self)
	Global.Cameraman.position = position

func _process(delta):
	printt(State_Controller.state_current, State_Controller.state_next)
	if Global.Settings.collect_all: _collect_discs()
	Input_Array = Input_Controller.combo_controller.input_sequence
	new_dir.y = input_look.y
	
	if Target:
		look_forward = true
		dir_to_target = Target.global_position - global_position
		dir_to_target.y = 0
		dist_to_target = abs(dir_to_target.length())
		if dir_to_target != Vector3.ZERO:
			var look_transform = Transform3D().looking_at(dir_to_target, Vector3.UP)
			new_dir.y = look_transform.basis.get_euler().y
		
	if look_forward: rotation.y = lerp_angle(rotation.y, new_dir.y, delta*10)

	if in_vehicle:
		is_moving = false
		global_position = in_vehicle.seats[0].global_position
	else:
		if !locked_in:
			_update_velocity(delta)

func _collect_discs():
	if Input.is_action_just_pressed("collect"):
		for disc in get_tree().get_nodes_in_group("Disc"):
			if disc.in_play:
				disc.takeoff_pos = disc.position
			disc.pick_up(Bag)

func get_aim_trace():
	if is_throwing: 
		if Input.get_last_mouse_velocity():
			predict_search = true
			aim_stable = false 
		else:
			if predict_cd <= 0:
				if predict_search:
					aim_stable = true
					predict_search = false
					predict_cd = predict_cd_max
					predict_trace = false
					#trace_disc()
			else:
				predict_cd -= 1
		prev_look_dir = look_dir

func clear_trace():
	predict_cd = 0
	var trace_path = get_tree().get_nodes_in_group("Trace")
	if trace_path:
		for trace in trace_path:
			trace.queue_free()

func get_overlapping_areas():
	return Area_Interact.get_overlapping_areas()

func cull():
	queue_free()

func set_target(new_target):
	if new_target: 
		Target = new_target
	
	else:
		Target = null
		var markers = get_tree().get_nodes_in_group("Target Marker")
		for marker in markers:
			marker.queue_free()

#func trace_disc():
	#if !predict_trace and aim_stable: 
		#var trace_path = get_tree().get_nodes_in_group("Trace")
		#if trace_path:
			#for trace in trace_path:
				#trace.queue_free()
		#var trace = Global.Refs.DISC_TRACE.instantiate()
		#add_child(trace)
		#trace.position = Hand.position
		#predict_trace = true
		#Global.HUD.charge_bar.value += 2
	#else:
		#predict_trace = false
