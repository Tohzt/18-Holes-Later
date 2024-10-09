extends CollisionShape3D
var isInside = false
@onready var ds = $'/root/Course/DiscSelector'

# Called when the node enters the scene tree for the first time.
func _ready():
	print("DISC_SELECTOR GEM_MACHJINE")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(isInside and Input.is_action_just_pressed("interact")):
		print("GOING TO INTERACT, FROM INSIDE GEM_MACHINE")
		print(ds)
		if(ds.is_visible()):
			ds.hide()
		else:
			ds.show()
	pass
	


func _on_area_body_3d_body_entered(_body):
	isInside = true

func _on_area_body_3d_body_exited(_body):
	isInside=false
