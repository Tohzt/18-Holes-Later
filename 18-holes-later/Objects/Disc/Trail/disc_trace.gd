class_name DiscTraceClass
extends Disc

var trace_cd_max = 4
var trace_cd = trace_cd_max/2.0
const TRACE = preload("res://Objects/Disc/Trail/trace.tscn")

func _ready():
	Global.Player.State_Controller.get_node("Throw").throw_disc(self, 5.0)

func _physics_process(delta):
	super._physics_process(delta)
	
	var collision = move_and_collide(Vector3.ZERO, true)
	if collision:
		grounded = true
	
	if !in_bag:
		if grounded:
			queue_free()
		else:
			_draw_prediction()

func _draw_prediction():
	trace_cd -= 1
	if trace_cd <= 0:
		trace_cd = trace_cd_max
		var trace = TRACE.instantiate()
		trace.position = position
		get_parent().add_child(trace)
