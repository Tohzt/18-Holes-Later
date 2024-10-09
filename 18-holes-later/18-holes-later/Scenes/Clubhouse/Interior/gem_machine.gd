extends CollisionShape3D
var isInside = false
@onready var ds = $'/root/Course/DiscSelector'
<<<<<<< HEAD:18-holes-later/18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd
=======
signal testSignal
>>>>>>> 60f5ee911de65afccbd9591872885f10dc656b24:18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd

# Called when the node enters the scene tree for the first time.
func _ready():
	print("DISC_SELECTOR GEM_MACHJINE")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
<<<<<<< HEAD:18-holes-later/18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd
func _process(_delta):
=======
func _process(delta):
>>>>>>> 60f5ee911de65afccbd9591872885f10dc656b24:18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd
	if(isInside and Input.is_action_just_pressed("interact")):
		print("GOING TO INTERACT, FROM INSIDE GEM_MACHINE")
		print(ds)
		if(ds.is_visible()):
			ds.hide()
		else:
			ds.show()
	pass
	


<<<<<<< HEAD:18-holes-later/18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd
func _on_area_body_3d_body_entered(_body):
	isInside = true

func _on_area_body_3d_body_exited(_body):
	isInside=false
=======
func _on_area_body_3d_body_entered(body):
	isInside = true
	pass # Replace with function body.


func _on_area_body_3d_body_exited(body):
	isInside=false
	pass # Replace with function body.
>>>>>>> 60f5ee911de65afccbd9591872885f10dc656b24:18-holes-later/Scenes/Clubhouse/Interior/gem_machine.gd
