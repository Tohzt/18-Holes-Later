extends Node

var disc_limit = 1
var game_disc_index: int = 0
var bag_of_discs: Array = [
	["Starter", "Driver", 2,2,-2,2],
	["Starter", "Hybrid", 1,1,-1,1],
	["Starter", "Putter", 0,0, 0,0]]
var discs: Array[RigidBody3D]

func _ready():
	for disc_data in bag_of_discs:
		var disc = Global.DISC.instantiate()
		disc.in_hand = true
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
		
