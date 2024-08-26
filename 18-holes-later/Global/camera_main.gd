extends Camera3D

@onready var rot_x = rotation.x

func _ready():
	Global.Active_Camera = self

func snap_to(anchor: Node3D):
	reparent(anchor.Tripod)
	anchor.Tripod.has_camera = self
	if anchor == Global.Player:
		rotation.x = rot_x
	else:
		get_parent().rotation.y = Global.Player.look_dir
		rotation.x = 0

func _process(_delta):
	rotation.y = 0
	rotation.z = 0
	if get_parent() == Global.Player.Tripod:
		rot_x = rotation.x
	else:
		rotation = Vector3.ZERO

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var parent = get_parent()
			var angle_limit_down = 80
			var angle_limit_up = 20
			# Update Vertical
			get_parent().rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
			get_parent().rotation.x = clampf(get_parent().rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			# Update Horizontal
			if Global.Player.Tripod.get_child_count():
				Global.Player.look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			else:
				parent.global_rotation.y += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			
