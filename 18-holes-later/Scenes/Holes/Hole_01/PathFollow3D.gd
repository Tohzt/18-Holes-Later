extends PathFollow3D
@onready var trees = $"../../Trees"

# TODO: Redo the fuck outa this
func _process(delta):
	progress_ratio += delta/10
	var tree = Global.TREE.instantiate()
	var random_offset = Vector3(randi_range(-10,10), 0, randi_range(-10,10))
	tree.position = position + get_parent().position + random_offset
	trees.add_child(tree)
	
	if progress_ratio >= .99:
		queue_free()
