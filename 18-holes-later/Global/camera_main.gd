extends Camera3D

@onready var rot_x = rotation.x

func _ready():
	Global.Active_Camera = self

func snap_to(anchor: Node3D, target: Disc = null):
	reparent(anchor.Tripod)
	anchor.Tripod.has_camera = self
	if target:
		anchor.Tripod.rotation.y = Global.Player.rotation.y
		anchor.position = target.position
		anchor.target = target
	# Reset rotation to looking direction
	if anchor == Global.Player:
		rotation.x = rot_x

func _process(_delta):
	rotation.y = 0
	rotation.z = 0
	if get_parent() == Global.Player.Tripod:
		# TODO: Do on release
		rot_x = rotation.x

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var _tripod = get_parent()
			var angle_limit_down = 80
			var angle_limit_up = 20
			if _tripod == Global.Player.Tripod:
				# Update Vertical
				_tripod.rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
				_tripod.rotation.x = clampf(_tripod.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
				# Update Horizontal
				Global.Player.look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			else:
				# Update Vertical
				rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
				rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down+20), deg_to_rad(angle_limit_up-15))
				# Update Horizontal
				_tripod.global_rotation.y += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			
