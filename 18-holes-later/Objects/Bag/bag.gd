extends Node

var slots:int =3
@export var discs:Array[Disc] = []
var resource_storage ={
	"boneDust":200,
	"charredRemains":200,
	"titaniumArmor":200,	
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_disc(disc:Disc):
	if(discs.size() >=slots):
		print("Bag is Full")
	discs.append(disc)
	
func remove_disc(discNumber):
	discs.remove_at(discNumber)
	
