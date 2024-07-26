extends Entity
@onready var Camera = $SpringArm3D
@onready var Hand = $Hand


const MAX_POWER = 20

var is_throwing = false

func _ready():
	super._ready()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if is_throwing: return
	
	move_and_slide()

func _unhandled_input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var angle_limit_down = 80
			var angle_limit_up = 20
			Camera.rotation.x = clampf(Camera.rotation.x, deg_to_rad(-angle_limit_down), deg_to_rad(angle_limit_up))
			
			if !is_throwing:
				Camera.rotate_x(deg_to_rad(-event.relative.y * Global.MOUSE_SENSITIVITY))
			elif State_Controller.state_suffix == "_Charge": return
			rotate_y(deg_to_rad(-event.relative.x * Global.MOUSE_SENSITIVITY))
