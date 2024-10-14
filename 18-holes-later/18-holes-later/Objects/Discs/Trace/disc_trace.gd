class_name DiscTraceClass
extends Disc

var trace_cd_max = 4
var trace_cd = trace_cd_max/2.0
const TRACE = preload("res://Objects/Discs/Trace/trace.tscn")

func _ready():
	is_tracer = true
	for disc: Disc in get_tree().get_nodes_in_group("Disc"):
		if disc.in_hand:
			stats = disc.stats
	Global.Player.State_Controller.get_node("Throw").throw_disc(self, 10.0)

func _physics_process(delta):
	super._physics_process(delta)
	
	var collision = move_and_collide(Vector3.ZERO, true)
	if collision:
		is_grounded = true
	
	if !in_bag:
		if is_grounded or position.y < -100:
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
