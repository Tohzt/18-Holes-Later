class_name disc_card_button
extends MarginContainer

var button:PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
var disc: Disc_Stats
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_pressed():
	var pup = Popup.new()
	var new_button = button.instantiate()
	var vbox = VBoxContainer.new()
	new_button.get_child(0).text = disc.disc_name
	pup.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	pup.size = Vector2(250,400)
	print("disc",disc.disc_name)
	vbox.alignment = VBoxContainer.AlignmentMode.ALIGNMENT_CENTER
	vbox.add_spacer(true)
	for discVal in disc.stats:
		var content = str(discVal) + " - "+ str(disc.stats[discVal])
		make_label(vbox,content)
	make_label(vbox, "Slots -" + str(disc.slot))
	vbox.add_child(new_button)
	pup.add_child(vbox)
	pup.borderless = false
	pup.title = $Button.text + ' Stats'
	
	add_sibling(pup)
	pup.show()
	print("you clicked me")
	print($Button.text)
	Global.store_disc_in_bag($Button.text)

func create_popup ():
	pass

	
func make_label (parent,content):
	var label = Label.new()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = content
	parent.add_child(label)
