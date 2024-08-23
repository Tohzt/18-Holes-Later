extends MarginContainer

var button:PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_pressed():
	var pup = Popup.new()
	var new_button = button.instantiate()
	new_button.get_child(0).text = $Button.text
	pup.add_child(new_button)
	pup.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	pup.borderless = false
	pup.title = "You are in charge,Dylan"
	add_sibling(pup)
	pup.show()
	print("you clicked me")
	print($Button.text)
