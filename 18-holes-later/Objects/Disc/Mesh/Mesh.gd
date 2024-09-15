extends Node

const CLASSIC_RETRO_DISC_MESH = preload("res://Objects/Disc/Mesh/classic_retro_disc_mesh.tscn")
const PLASMA_DISC_MESH = preload("res://Objects/Disc/Mesh/plasma_disc_mesh.tscn")
const RETRO_DISC_MESH = preload("res://Objects/Disc/Mesh/retro_disc_mesh.tscn")
const meshs = [
	preload("res://Objects/Disc/Mesh/classic_retro_disc_mesh.tscn"),
	preload("res://Objects/Disc/Mesh/plasma_disc_mesh.tscn"),
	preload("res://Objects/Disc/Mesh/retro_disc_mesh.tscn"),
	preload("res://Objects/Disc/Mesh/disc_mid_laker.tscn"),
	]

func _ready():
	_clear_mesh()
	_set_mesh()

func _clear_mesh():
	for mesh in get_children(): mesh.queue_free()

func _set_mesh(new_mesh: MeshInstance3D = null):
	if !new_mesh: new_mesh = meshs.pick_random().instantiate()
	add_child(new_mesh)
