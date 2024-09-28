class_name Entity_Character
extends Entity
 
@onready var Hand = $Hand
@onready var Bag = $Bag

var game_disc_index: int = 0

const MAX_POWER = 10
var can_throw = false
var can_look = true
var can_jump = true
var is_charging = false
var is_throwing = false
var is_on_tee = false
var locked_in = false
var aim_stable = false
var prev_look_dir = look_dir

var in_vehicle: CharacterBody3D

# Trace Properties
var predict_trace = false
var predict_search = false
var predict_cd_max = 50
var predict_cd = 0

func _ready():
	Global.Cameraman.set_target(self, $CamFocus)
	Global.Player = self
	super._ready()

func _process(delta):
	Input_Controller.char_look = false if Global.Hole_Name == "Clubhouse_Interior" else true
	if in_vehicle:
		rotation.y = in_vehicle.rotation.y
	else:
		rotation.y = lerp_angle(rotation.y, new_dir.y, delta*10) 
	
	if is_throwing: get_aim_trace()
	
	if Global.Debug_Settings.collect_all:
		_collect_discs()

func _physics_process(delta):
	speed_mult = 1
	if Input.is_action_pressed("run"):
		speed_mult = SPEED_MULT
	var _speed = SPEED * speed_mult
	
	if input_dir:
		velocity.x = input_dir.x * _speed
		velocity.z = input_dir.z * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.z = move_toward(velocity.z, 0, _speed)
	
	if is_on_floor():
		if is_falling:
			# TODO: Move this to landing state
			#anim_play("Land")
			is_falling = false
		if is_jumping:
			velocity.y = 5
		can_jump = true
	else:
		if velocity.y < 0:
			if !is_falling:
				anim_play("Falling")
				is_falling = true
			is_jumping = false
		if !in_vehicle:
			velocity.y -= gravity * delta
	
	if in_vehicle:
		is_moving = false
		global_position = in_vehicle.seats[0].global_position
	else:
		if !locked_in:
			move_and_slide()

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
					trace_disc()
			else:
				predict_cd -= 1
		prev_look_dir = look_dir

func trace_disc():
	if !predict_trace and aim_stable: 
		var trace_path = get_tree().get_nodes_in_group("Trace")
		if trace_path:
			for trace in trace_path:
				trace.queue_free()
		var trace = Global.Refs.DISC_TRACE.instantiate()
		add_child(trace)
		trace.position = Hand.position
		predict_trace = true
		Global.HUD.charge_bar.value += 2
	else:
		predict_trace = false

func clear_trace():
	predict_cd = 0
	var trace_path = get_tree().get_nodes_in_group("Trace")
	if trace_path:
		for trace in trace_path:
			trace.queue_free()

func anim_play(anim):
	Anim_Controller.animation_player.play(anim)
