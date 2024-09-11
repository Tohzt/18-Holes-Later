extends Node

func save_game(profile: String = ""):
	print("Saving Profile: ", profile)
	var save_game_file   = FileAccess.open("user://save_data/save_game.save",   FileAccess.WRITE)
	var save_course_file = FileAccess.open("user://save_data/save_course.save", FileAccess.WRITE)
	var save_char_file   = FileAccess.open("user://save_data/save_char.save",   FileAccess.WRITE)
	var save_disc_file   = FileAccess.open("user://save_data/save_disc.save",   FileAccess.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print_debug("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print_debug("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		print("Type: ", node_data.type)
		match node_data.type:
			"Game":
				save_game_file.store_line(json_string)
				print("Game Save: ", node_data.type)
			"Course":
				save_course_file.store_line(json_string)
				print("Course Save: ", node_data.type)
			"Char":
				save_char_file.store_line(json_string)
				print("Character Save: ", node_data.type)
			"Disc":
				save_disc_file.store_line(json_string)
				print("Disc Save: ", node_data.type)

func load_game(_profile: String = ""):
	if !FileAccess.file_exists("user://save_data/save_game.save")   \
	or !FileAccess.file_exists("user://save_data/save_course.save") \
	or !FileAccess.file_exists("user://save_data/save_char.save")   \
	or !FileAccess.file_exists("user://save_data/save_disc.save"):
		return # Error! We don't have a save to load.
	
	# Delete Persistent Nodes (Excluding Game)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		if i.get_parent().name != "Game":
			i.get_parent().queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var load_game_file   = FileAccess.open("user://save_data/save_game.save",   FileAccess.READ)
	var load_course_file = FileAccess.open("user://save_data/save_course.save", FileAccess.READ)
	var load_char_file   = FileAccess.open("user://save_data/save_char.save",   FileAccess.READ)
	var load_disc_file   = FileAccess.open("user://save_data/save_disc.save",   FileAccess.READ)
	
	_init_game(load_game_file)
	_init_course(load_course_file)
	_init_char(load_char_file)
	_init_disc(load_disc_file)

func _init_game(file):
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		
		# Creates the helper class to interact with JSON
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print_debug("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data = json.get_data()
			
		print("Loading Profile: ", node_data)

func _init_course(file: FileAccess):
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		
		# Creates the helper class to interact with JSON
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print_debug("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data = json.get_data()
		
			# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])

func _init_char(file):
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		
		# Creates the helper class to interact with JSON
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print_debug("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data = json.get_data()
		
			# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		new_object.position = Vector3(node_data["pos_x"], node_data["pos_y"], node_data["pos_z"])
		get_node(node_data["parent"]).add_child(new_object)
		
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])


func _init_disc(file):
	pass # TODO: Do I need to save discs yet?
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		
		# Creates the helper class to interact with JSON
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print_debug("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data = json.get_data()
		
			# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		new_object.position = Vector3(node_data["pos_x"], node_data["pos_y"], node_data["pos_z"])
		get_node(node_data["parent"]).add_child(new_object)
		
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
