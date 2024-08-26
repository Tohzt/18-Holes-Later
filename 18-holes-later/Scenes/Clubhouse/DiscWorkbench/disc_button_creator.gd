extends VBoxContainer

var DiscButton: PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
var slots:int = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		var new_disc_button = DiscButton.instantiate()
		new_disc_button.get_child(0).text = "autocreated button" + str(i) 
		print("adding child button ")
		add_child(new_disc_button)		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
