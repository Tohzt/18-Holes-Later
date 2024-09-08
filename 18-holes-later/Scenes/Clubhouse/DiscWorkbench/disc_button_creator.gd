extends VBoxContainer

var DiscButton: PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
var slots:int = 68
# Called when the node enters the scene tree for the first time.
func _ready():
	var discs = await getResources()
	print(discs)
	for disc in discs:
		var new_disc_button = DiscButton.instantiate()
		new_disc_button.get_child(0).text = disc.disc_name
		new_disc_button.disc = disc
		print("adding child button ")
		add_child(new_disc_button)		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
				print("Found directory: " + file_name)
			elif file_name.ends_with("tres"):
				print("Found file: " + file_name)
				#print(folder_path + "/" + file_name)
				var scene:Disc_Stats = load(folder_path + "/" + file_name)
				print(scene.disc_name)
				scenes.push_back(scene)
				file_name = dir.get_next()
			else:
				file_name = dir.get_next()
				
	else:
		print("An error occurred when trying to access the path.")
	return scenes
