extends Node3D
const TREE = preload("res://Objects/Trees/tree.tscn")
@onready var trees = $"../Trees"

@export var spawn_treed := false
@export_range (1,10) var tree_density: int
@export var offset_range := randi_range(0,0)

func _ready():
	if spawn_treed:
		for rot in floor(360/5):
			for i in tree_density:
				var tree = TREE.instantiate()
				tree.position = _offset()
				trees.add_child(tree)
			rotate_y(deg_to_rad(15))

func _offset() -> Vector3:
	return Vector3(($Spawner.global_position.x + randi_range(offset_range/2, offset_range)*[-1,1].pick_random()),0,($Spawner.global_position.z + + randi_range(offset_range/2, offset_range)*[-1,1].pick_random()))
