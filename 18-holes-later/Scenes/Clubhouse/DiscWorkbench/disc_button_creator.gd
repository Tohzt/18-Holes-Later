extends VBoxContainer

var DiscButton: PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
var slots:int = 68
# Called when the node enters the scene tree for the first time.
func _ready():
	var discs = getResources()
	for disc in discs:
		var new_disc_button = DiscButton.instantiate()
		#var mat = d
		#var _textre: Texture = null
		#var _disc = TextureRect.new()
		#var _mesh_texture = MeshTexture.new()
		#_mesh_texture.mesh = disc
		#_disc.material = _mesh_texture
		#_disc.size = Vector2(100,100)
		#print(_disc.size)
		#new_disc_button.add_child(_disc) 
		new_disc_button.get_child(0).text = "autocreated button"
		print("adding child button ")
		add_child(new_disc_button)		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getResources ():
	var folder_path = "res://Objects/Disc/Mesh"
	var scenes = []
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			elif file_name.ends_with("tres"):
				print("Found file: " + file_name)
				#print(folder_path + "/" + file_name)
				var scene = load(folder_path + "/" + file_name)
				print(scene)
				scenes.push_back(scene)
				file_name = dir.get_next()
			else:
				file_name = dir.get_next()
				
	else:
		print("An error occurred when trying to access the path.")
	return scenes
