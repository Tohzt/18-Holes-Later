extends AnimatedSprite3D
class_name AnimationController

@onready var player = $"../"

var anim_type := ""
var anim_dir := ""
var anim_dir_prev := ""
var anim := ""

func _ready():
	anim_type = "Idle"
	anim = "Idle_D"

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			play("Attack_Side")

func _process(_delta):
	if anim_dir == "":
		_update_animation()
		
	if animation != anim:
	
		if anim == "Idle_":
			anim = anim + "D"
		play(anim)
	print(animation + " :: " + anim)

func _update_animation():
	anim = anim_type + "_"
	var h_axis = Input.get_axis("move_left", "move_right")
	var v_axis = Input.get_axis("move_backward", "move_forward")
	if v_axis:
		var dir = "U" if v_axis == 1 else "D"
		anim = anim + dir
	if h_axis:
		var dir = "R" if h_axis == 1 else "L"
		anim = anim + dir
