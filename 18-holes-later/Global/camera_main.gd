extends Camera3D

@onready var rot = rotation

func _ready():
	Global.Active_Camera = self

func snap_to(anchor: Node3D):
	rotation.x = 0
	rotation.y = 0
	rotation.z = 0
	reparent(anchor.Tripod)

func _process(delta):
	#position = Vector3.ZERO
	if !Global.Player.Tripod.get_child_count():
		rotation.x = 0
	rotation.y = 0
	rotation.z = 0
	#rotation = rot

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var parent = get_parent()
			var angle_limit_down = 80
			var angle_limit_up = 20
			#rotation.x = clampf(rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			
			rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
			if Global.Player.Tripod.get_child_count():
				Global.Player.look_dir += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			else:
				parent.global_rotation.y += deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY)
			
