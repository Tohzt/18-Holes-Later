extends Node

const CLASSIC_RETRO_DISC_MESH = preload("res://Objects/Disc/Mesh/classic_retro_disc_mesh.tscn")
const PLASMA_DISC_MESH = preload("res://Objects/Disc/Mesh/plasma_disc_mesh.tscn")
const RETRO_DISC_MESH = preload("res://Objects/Disc/Mesh/retro_disc_mesh.tscn")
const meshs = [
	preload("res://Objects/Disc/Mesh/classic_retro_disc_mesh.tscn"),
	preload("res://Objects/Disc/Mesh/plasma_disc_mesh.tscn"),
	preload("res://Objects/Disc/Mesh/retro_disc_mesh.tscn")]

func _ready():
	var mesh = meshs.pick_random().instantiate()
	get_parent().get_node("Mesh").add_child(mesh)
