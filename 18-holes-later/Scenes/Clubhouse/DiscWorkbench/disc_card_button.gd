class_name disc_card_button
extends MarginContainer

#var button:PackedScene = preload("res://Scenes/Clubhouse/DiscWorkbench/DiscCardButton.tscn")
var disc: Disc_Stats
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_pressed():
	create_popup()
	create_gem()
	print("you clicked me")
	print($Button.text)
	Global.store_disc_in_bag($Button.text)

func create_gem ():
	var gem = preload("res://Objects/Gems/Gems.gd").new()
	await gem.initialize_gem()
	print('create_gem')
	var pup2 = Popup.new()
	var vbox = VBoxContainer.new()
	vbox.alignment = VBoxContainer.AlignmentMode.ALIGNMENT_END
	vbox.add_spacer(true)
	pup2.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	pup2.size = Vector2(250,400)
	pup2.borderless = false
	for _msh:Shard_Special in gem.master_shard:
		make_label(vbox,str(_msh.element_type.keys()[_msh.elemental]) +str(_msh.damage_type.keys()[_msh.damage]))
	for _sh:Shard in gem.shard_array:
		make_label(vbox,str(_sh.name))
	pup2.add_child(vbox)
	add_sibling(pup2)
	pup2.show()
	#pup2.add_child(gem)

func create_popup ():
	var pup = Popup.new()
	var new_button = Button.new()
	var vbox = VBoxContainer.new()
	new_button.text = disc.disc_name
	pup.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	pup.size = Vector2(250,400)
	print("disc",disc.disc_name)
	vbox.alignment = VBoxContainer.AlignmentMode.ALIGNMENT_CENTER
	vbox.add_spacer(true)
	var hbox = HBoxContainer.new()
	hbox.alignment = HBoxContainer.AlignmentMode.ALIGNMENT_CENTER
	hbox.add_spacer(true)
	var hbox2 = HBoxContainer.new()
	hbox2.alignment = HBoxContainer.AlignmentMode.ALIGNMENT_CENTER
	hbox2.grow_horizontal = Control.GROW_DIRECTION_BOTH
	hbox2.add_spacer(true)
	for discVal in disc.stats:
		var content = str(discVal) + " - "+ str(disc.stats[discVal])
		make_label(hbox2,content)
	for slot in disc.slot:
		make_label(hbox, "Slots -" + str(slot))
	vbox.add_child(hbox2)
	vbox.add_child(hbox)
	vbox.add_child(new_button)
	pup.add_child(vbox)
	pup.borderless = false
	pup.title = $Button.text + ' Stats'
	
	add_sibling(pup)
	pup.show()

	
func make_label (parent,content):
	var label = Label.new()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = content
	parent.add_child(label)
