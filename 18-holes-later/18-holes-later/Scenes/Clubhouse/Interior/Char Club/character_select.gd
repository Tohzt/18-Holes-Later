extends Node3D
@onready var Cam_Mount = $Cam_Mount
@onready var Target: Node3D

var target_offset_index = 0
var look_forward = true
var look_around = false
var accepts_input = false
var sight = INF

var enemies_in_range: Array[Node3D]

func _ready():
	enemies_in_range = Global.get_objects_in_range(self, "Target", sight)
	Target = enemies_in_range.front()

func _process(_delta):
	if !accepts_input: return
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if Target:
		if Input.is_action_just_pressed("lock_cycle_up"):
			target_offset_index += 1
			update_index()
		if Input.is_action_just_pressed("lock_cycle_down"):
			target_offset_index -= 1
			update_index()
		if Input.is_action_just_pressed("left_click"):
			_select_character()

func _select_character():
	if !Target: return
	accepts_input = false
	
	Global.Transition.toggle_fade(true)
	Global.audio_stream_player.play()
	
	await get_tree().create_timer(1.0).timeout
	var anim = Target.character_reference.instantiate()
	Global.Cameraman.set_target(Global.Player)
	Global.Player.Anim_Controller.queue_free()
	Global.Player.add_child(anim)
	await get_tree().create_timer(1.0).timeout
	Global.Transition.toggle_fade(false)
	

func update_index():
	#target_offset_index = clamp(target_offset_index, -1, 1)
	target_offset_index = target_offset_index % enemies_in_range.size()
	if enemies_in_range:
		var enemy_nearest = enemies_in_range[target_offset_index]
		if enemy_nearest:
			Target = enemy_nearest
			Global.Cameraman.set_target(Target)

func set_active(_TorF: bool = false):
	accepts_input = true
