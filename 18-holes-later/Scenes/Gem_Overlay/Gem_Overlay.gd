extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("gem_overlay started")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_released("bag")):
		if(!visible):
			show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			pass
	pass
