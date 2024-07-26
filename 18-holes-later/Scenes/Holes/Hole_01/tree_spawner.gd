extends Node3D

const TREE = preload("res://Objects/Trees/tree.tscn")
@onready var trees = $"../Trees"
@export_range (1.0, 50.0) var frequency:    float = 5.0
@export_range (1,10)      var tree_density: int = 5

func _ready():
	for rot in floor(360.0/frequency):
		for i in tree_density:
			var tree = TREE.instantiate()
			tree.position = _offset()
			trees.add_child(tree)
		rotate_y(deg_to_rad(frequency))

func _offset() -> Vector3:
	var rand_dir = deg_to_rad(randi_range(0,360))
	var rand_dist = randi_range(0, 5)
	var spawner_pos = $Spawner.global_position
	var offset = Vector3(rand_dist * cos(rand_dir), 0, rand_dist * sin(rand_dir))
	return spawner_pos + offset
