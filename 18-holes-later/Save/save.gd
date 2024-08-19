extends Node

@export_category("Save Properties")
@export var is_game:   bool = false
@export var is_course: bool = false
@export var is_char:   bool = false
@export var is_disc:   bool = false

@onready var parent = get_parent()

func save():
	var save_dict
	if is_game:   save_dict = _get_game_save()
	if is_course: save_dict = _get_course_save()
	if is_disc:   save_dict = _get_disc_save()
	if is_char:   save_dict = _get_character_save()
	return save_dict

func _get_game_save():
	var game_save_dict ={
		"type": "Game",
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path(),
		"profile": Global.Profile,
	}
	return game_save_dict
	
func _get_course_save():
	var course_save_dict ={
		"type": "Course",
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path()
	}
	return course_save_dict

func _get_character_save():
	var char_save_dict = {
		"type" : "Char",
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path(),
		"pos_x" : parent.position.x,
		"pos_y" : parent.position.y,
		"pos_z" : parent.position.z,
		# TODO: Add Player Properties to Save
	}
	return char_save_dict

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
