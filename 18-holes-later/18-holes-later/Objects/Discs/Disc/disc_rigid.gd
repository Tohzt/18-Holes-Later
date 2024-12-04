class_name Disc_RigidBod_Class
extends RigidBody3D

@onready var Cam_Mount = $Cam_Mount

@export_category("Disc Base Stats")
var index = 1
@export var disc_name = ""
@export var disc_type = ""
@export var stats = {
	"Speed": 0,  # (1-14) a value added to the POWER determined from charging so a higher speed = further throw at the same POWER
	"Glide": 0,  # (1-7)  How long it stays in the air. a higher number fights gravity at a slower rate (gravity delta)
	"Turn":  0,  # (1--5) Ignore for now
	"Fade":  0,  # (0-5)  Ignore for now
	"Resistance": 0.01  # Rate that disc loses power, aka the rate of which it lowers the forwards velocity. Also determines the rate of which the disc strafes/tilts from right to left.
}

@export_category("Disc Combat Stats")
@export var dmg = 5
var target_dir: Vector3
var power: float
var power_init: float

var takeoff_pos: Vector3
var in_throw = false
var in_bag = false
var in_hand = false

# Needed for Cameraman to follow
var look_forward = true
var look_around = false

var owned_by_player = false
var flight_phase = 0  # 0 = initial turn, 1 = fade
var turn_strength: float
var fade_strength: float

var initial_rightward_force := 25.0
@onready var disc_mesh = $Mesh
var max_tilt_angle := 45.0
var max_vertical_tilt_angle := 20.0
var horizontal_influence := 0.0
var initial_tilt_factor: float = 0.0
var launch_height: float = 0.0
var optimal_height_range: float = 2.0  # Height difference where bonus applies

func _ready():
	freeze = true
	angular_damp = 8.0
	linear_damp = 0.0
	can_sleep = false
	# Keep collision detection improvements
	contact_monitor = true
	max_contacts_reported = 4
	continuous_cd = true
	custom_integrator = false
	
	# Connect the body entered signal instead
	body_entered.connect(_on_body_entered)
	print("Body collision signal connected")

func launch_disc():
	if not is_instance_valid(self):
		return
	
	print("Launching disc: ", disc_name, " with stats: ", stats)
	
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(2, true)
	self.set_collision_mask_value(4, true)
	takeoff_pos = position
	in_throw = true
	in_hand = false
	in_bag = false
	
	# Reset physics state
	rotation = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	if not is_instance_valid(get_tree()):
		return
	
	# Only reparent and set camera properties for non-combat throws
	if !Global.Player.Target:  # If there's no target, it's a normal throw
		reparent(get_tree().root)
		look_forward = true
		look_around = false
	else:
		# For combat throws, just reparent without camera setup
		reparent(get_tree().root)
		look_forward = true
		look_around = false
	
	target_dir = -target_dir.normalized()
	
	# Add slight downward angle to initial launch
	target_dir.y -= 0.1  # Adds a slight downward component to throw
	
	power += stats["Speed"] * 0.8
	var scaled_power = pow(power, 1.3)
	power_init = power
	
	var forward_force = target_dir * scaled_power * 1.1
	freeze = false
	apply_central_impulse(forward_force)
	
	look_at(position + target_dir)
	
	# Store the initial tilt factor right before applying forces
	var initial_tilt = rotation.z
	initial_tilt_factor = max(0, -initial_tilt) / deg_to_rad(max_tilt_angle)
	launch_height = global_position.y  # Store the launch height

func _physics_process(delta):
	if in_throw:
		# Remove velocity limiting
		_apply_forces(delta)
		_calculate_drift()
		power -= stats["Resistance"] * delta * 10
	
	_self_cull()

func _apply_forces(delta):
	if not in_hand and not in_bag:
		# Calculate height difference from launch
		var height_diff = abs(global_position.y - launch_height)
		var height_bonus = 1.0
		
		# Apply speed bonus when close to launch height
		if height_diff < optimal_height_range:
			height_bonus = 1.0 + (1.0 - height_diff/optimal_height_range) * 0.3  # Up to 30% speed bonus
		
		# Get the current tilt angle (positive = right tilt)
		var tilt_angle = rotation.z
		var right_tilt = max(0, -tilt_angle)
		var current_tilt_factor = right_tilt / deg_to_rad(max_tilt_angle)
		
		# Smoothly blend between current and initial tilt
		var blended_tilt = lerp(current_tilt_factor, initial_tilt_factor, 0.5)
		
		# Apply lift force with height consideration
		var forward_speed = -linear_velocity.dot(transform.basis.z)
		if forward_speed > 0:
			var base_lift = forward_speed * stats["Glide"] * 0.08
			var tilt_lift_bonus = base_lift * blended_tilt * 0.5
			var lift_force = Vector3.UP * (base_lift + tilt_lift_bonus)
			lift_force.y -= 0.2
			apply_central_force(lift_force)
		
		# Apply drag with height bonus
		var drag_reduction = (1.0 - (blended_tilt * 0.4)) * height_bonus
		var drag = -linear_velocity * stats["Resistance"] * 0.45 * drag_reduction
		apply_central_force(drag * height_bonus)  # Apply height bonus to drag

func _calculate_drift():
	var flight_progress = 1.0 - (power / power_init)
	var ramp_up = pow(flight_progress * 3.0, 0.5) * (1.0 - flight_progress)
	ramp_up = clamp(ramp_up, 0.0, 1.0)
	
	var side_force
	if horizontal_influence > 0:
		var initial_force = initial_rightward_force * (2.5 + horizontal_influence)
		side_force = lerp(initial_force * ramp_up, -initial_rightward_force * 0.7, pow(flight_progress, 0.5))
	elif horizontal_influence < 0:
		var left_force = initial_rightward_force * abs(horizontal_influence) * 2.0
		side_force = -left_force * ramp_up * (1.1 + pow(flight_progress, 0.4))
	else:
		side_force = lerp(0.0, -initial_rightward_force * 0.4, pow(flight_progress, 0.4))
	
	# More stable side forces
	var side_vector = transform.basis.x * side_force * 0.8
	apply_central_force(side_vector)
	
	# More stable rotation calculations
	var horizontal_tilt = max_tilt_angle * sign(side_force) * (ramp_up + 0.15)
	var vertical_tilt = max_vertical_tilt_angle * clamp(linear_velocity.y / 12.0, -0.8, 0.8)
	
	var target_rotation = Vector3(
		deg_to_rad(-vertical_tilt),
		rotation.y,
		deg_to_rad(-horizontal_tilt)
	)
	
	# Much smoother torque application
	var rotation_diff = target_rotation - rotation
	var smooth_torque = rotation_diff * 3.0
	smooth_torque = smooth_torque.limit_length(0.3)
	smooth_torque.z += 0.03
	
	# Add stabilizing torque
	var stabilizing_torque = -angular_velocity * 2.0
	apply_torque(smooth_torque + stabilizing_torque)

func _integrate_forces(state: PhysicsDirectBodyState3D):
	if position.distance_to(takeoff_pos) > 1000:
		queue_free()
	if state.get_contact_count() > 0:
		for i in state.get_contact_count():
			var collider = state.get_contact_collider_object(i)
			if collider and collider.is_in_group("Solid"):
				# HACK: 
				queue_free()
				return
				var normal = state.get_contact_local_normal(i)
				state.linear_velocity = state.linear_velocity.bounce(normal)
				power *= 0.7

func pick_up(node: Node):
	self.set_collision_mask_value(2, false)
	in_bag = true
	in_throw = false
	freeze = true
	reparent(node)

func _self_cull():
	if position.y < -100:
		if owned_by_player:
			pick_up(Global.Player.Bag)
		else:
			queue_free()

func set_horizontal_influence(influence: float):
	print("Disc receiving influence: ", influence)
	horizontal_influence = influence
	disc_mesh.rotation_degrees.z = -influence * max_tilt_angle

func set_active(_TorF):
	pass

func _on_area_entered(area):
	print("Area entered by: ", area.name)
	if area.get_parent().is_in_group("Zombie") and in_throw:
		print("Disc hit zombie's area!")
		var knockback = linear_velocity * 2.0
		knockback.y = 20.0  # Strong upward force
		
		var zombie = area.get_parent()
		if zombie.has_method("apply_knockback"):
			zombie.apply_knockback(knockback)
			print("Applied knockback from disc: ", knockback)

func _on_body_entered(body):
	print("Body entered by: ", body.name)
	if (body.is_in_group("Zombie") or body.is_in_group("Target")) and in_throw:
		print("Disc hit target!")
		
		# Scale horizontal force more than vertical
		var knockback = linear_velocity * 3.0  # Increase horizontal force
		knockback.y = 5.0  # Reduced upward force
		
		if body.has_method("apply_knockback"):
			body.apply_knockback(knockback)
			print("Applied knockback from disc: ", knockback)

	
