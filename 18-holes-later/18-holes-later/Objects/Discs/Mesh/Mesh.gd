extends Node

const CLASSIC_RETRO_DISC_MESH = preload("res://Objects/Discs/Mesh/classic_retro_disc_mesh.tscn")
const PLASMA_DISC_MESH = preload("res://Objects/Discs/Mesh/plasma_disc_mesh.tscn")
const RETRO_DISC_MESH = preload("res://Objects/Discs/Mesh/retro_disc_mesh.tscn")
const meshs = [
	CLASSIC_RETRO_DISC_MESH,
	PLASMA_DISC_MESH,
	RETRO_DISC_MESH, 
	]

func _ready():
	_clear_mesh()
	_set_mesh()

func _clear_mesh():
	for mesh in get_children(): mesh.queue_free()

func _set_mesh(new_mesh: MeshInstance3D = null):
	if !new_mesh: new_mesh = meshs.pick_random().instantiate()
	add_child(new_mesh)
