extends Node

# Disc Properties
var disc_limit = 1
var game_disc_index: int = 0
var bag_of_discs: Array = [
	["Cold Stone","Putter",2,2,-1,0],
	["Midrock","Hybrid",5,4,0,3],
	["Innova Boss","Driver",13,5,-1,3]]
var discs: Array[CharacterBody3D]

func _ready():
	var index = 0
	for disc_data in bag_of_discs:
		index+=1
		var disc = Global.Refs.DISC.instantiate()
		disc.index = index
		disc.in_bag = true
		disc.position = get_parent().position
		disc.position.y = get_parent().position.y - 10
		disc.disc_name = disc_data[0]
		disc.disc_type = disc_data[1]
		disc.stats = {
			"Speed": disc_data[2],  # (1-14) Minimum power to throw stable
			"Glide": disc_data[3],  # (1-7)  How long it stays in the air (gravity delta)
			"Turn":  disc_data[4],  # (1--5) Expected distance before curve at perfect speed
			"Fade":  disc_data[5],  # (0-5)  How hard it wants to curve
			"Resistance": .5  # Rate that disc loses power
			}
		discs.append(disc)
		add_child(disc)
		
func _process(_delta):
	for disc: Disc in Global.Player.Bag.get_children():
		if disc.index == Global.selected_disc:
			disc.in_bag = false
			disc.in_hand = true
	
	if Input.is_action_just_pressed("tab"):
		Global.select_next_disc()
