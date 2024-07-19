extends AnimatedSprite3D
@onready var player = $".."

func _ready():
	play("Idle")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			play("Attack_Side")

func _process(_delta):
	if Input.is_action_just_pressed("move_left"):
		play("Walk_Side")
	if Input.is_action_just_pressed("move_right"):
		play("Walk_Side")
	if Input.is_action_just_pressed("move_forward"):
		play("Walk_Up")
	if Input.is_action_just_pressed("move_backward"):
		play("Walk_Down")
