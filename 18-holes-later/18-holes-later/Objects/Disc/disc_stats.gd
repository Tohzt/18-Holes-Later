class_name Disc_Stats
extends Resource

#
@export var slot = 1
@export var disc_name = ""
@export var disc_type = ""
@export var stats = {
	"Speed": 0,  # (1-14) Minimum power to throw stable
	"Glide": 0,  # (1-7)  How long it stays in the air (gravity delta)
	"Turn":  0,  # (1--5) Expected distance before curve at perfect speed
	"Fade":  0,  # (0-5)  How hard it wants to curve
	"Resistance": .5  # Rate that disc loses power
	}

func _init(_slot=1,_disc_name="",_disc_type="",_stats={}):
	slot = _slot
	disc_name = _disc_name
	disc_type = _disc_type
	stats = _stats 
	pass # Replace with function body.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
