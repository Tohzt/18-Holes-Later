extends Collect_Class

@onready var mesh: MeshInstance3D = $Mesh

@onready var h_start : float = position.y
@onready var h_bounce : float = h_start + .5
var bounce: bool = true

func _ready():
	position.y = randf_range(h_start, h_bounce)
	var random_material = Global.Refs.GEM_ARRAY.pick_random()
	mesh.set_surface_override_material(0, random_material)

func collect():
	if can_collect:
		print_debug("Collect Gem")

func _process(delta):
	if bounce:
		position.y = lerp(position.y, h_bounce, delta)
		if abs(position.y - h_bounce) < 0.1:
			bounce = false
	else:
		position.y = lerp(position.y, h_start, delta)
		if abs(position.y - h_start) < 0.1:
			bounce = true
