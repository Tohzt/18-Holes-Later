extends VBoxContainer

var DiscButton: PackedScene = preload("res://Scenes/UI/Disc Selector/Components/DiscCardButton.tscn")
var slots:int = 68

func _ready():
	var discs = await getResources()
	print(discs)
	for disc in discs:
		var new_disc_button = DiscButton.instantiate()
		new_disc_button.get_child(0).text = disc.disc_name
		new_disc_button.disc = disc
		add_child(new_disc_button)

func getResources ():
	var folder_path = "res://Objects/Disc"
	var scenes = []
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			if dir.current_is_dir():
				file_name = dir.get_next()
			elif file_name.ends_with("tres"):
				print("DiscButton Path: ", folder_path + "/" + file_name)
				#var scene:Disc_Stats = load(folder_path + "/" + file_name)
				#scenes.push_back(scene)
				file_name = dir.get_next()
			else:
				file_name = dir.get_next()
				
	else:
		print_debug("An error occurred when trying to access the path.")
	return scenes
