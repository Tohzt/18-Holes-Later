class_name Entity_Zombie
extends Entity

@export var is_burried := false
@onready var start_pos := global_position

var burry_depth = 1.5
var rotation_speed: float = 5.0
var timer: Timer
var is_walking = false

func _ready():
	accepts_input = true
	can_move = true
	SPEED = 200
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	if is_burried:
		State_Controller.state_next = "Burried"

func _process(delta): 
	if Target:
		dir_to_target = global_position.direction_to(Target.global_position)
		dist_to_target = global_position.distance_to(Target.global_position)
	new_dir.y = input_look.y
	if !is_burried: _update_velocity(delta)
	if !Target: return
	
	# TODO: use dist_to_target (also in burried state)
	var direction = global_position - Target.global_position
	direction.y = 0
	if direction.length() > 0.01:  
		# Get the rotation to look at target
		var look_at_point = global_position + direction.normalized()
		var target_basis = global_transform.looking_at(look_at_point).basis
		
		# Smoothly interpolate rotation
		var current_basis = global_transform.basis
		global_transform.basis = current_basis.slerp(target_basis, rotation_speed * delta)

# Alternative version using look_at() if you want instant rotation
func instant_look_at_target() -> void:
	if Target:
		var direction = Target.global_position - global_position
		direction.y = 0  # Keep character upright
		
		if direction.length() > 0.01:
			look_at(Target.global_position, Vector3.UP)

func _on_body_entered(body):
	if body.is_in_group("Disc"):
		take_damage(10,Vector3.UP*10)

func _on_area_3d_area_entered(area):
	if area.name == "BoneHand":
		print_debug("Disabled collision with bone")
		#take_damage(10,Vector3.UP*10)

func _on_timer_timeout():
	pass
	#$GPUParticles3D.emitting = true
	#$GPUParticles3D.reparent(get_parent())
	#queue_free()
