extends Node

@export_category("Save Properties")
@export var is_game: bool = false
@export var is_player: bool = false
@export var is_disc: bool = false

@onready var parent = get_parent()

func save():
	var save_dict
	if is_game: save_dict = _get_game_save()
	if is_disc: save_dict = _get_disc_save()
	if is_player: save_dict = _get_player_save()
	return save_dict

func _get_game_save():
	var game_save_dict ={
		"type": "Game",
		"profile": Global.Profile,
		"game_disc_index": parent.game_disc_index,
		"bag": parent.Bag
	}
	return game_save_dict

func _get_player_save():
	var disc_save_dict = {
		"type" : "Player",
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path(),
		"pos_x" : parent.position.x,
		"pos_y" : parent.position.y,
		"pos_z" : parent.position.z,
		# TODO: Add Player Properties to Save
	}
	return disc_save_dict

func _get_disc_save():
	var disc_save_dict = {
		"type": "Disc",
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path(),
		"pos_x" : parent.position.x,
		"pos_y" : parent.position.y,
		"pos_z" : parent.position.z,
		# TODO: Add Disc Properties to Save
	}
	return disc_save_dict
