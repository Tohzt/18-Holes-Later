extends CharacterBody2D

const DISC = preload("res://disc/disc.tscn")
var discs = 3
var move := Vector2.ZERO
var mouse_pos : Vector2
const SPEED = 300.0
var charging = false
var throwing = false
var stuck = false
var disc_in_air = false

var power = 0
var spin = 0

func _ready():
	mouse_pos = position

func _process(_delta):
	if charging:
		set_spin()
		power += 1
	
func _unhandled_input(event): 
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				charging = true
			else:
				charging = false
				mouse_pos = event.position
				throw()

func _physics_process(delta):
	var h_spd = Input.get_axis("ui_left", "ui_right") * SPEED * delta
	var v_spd = Input.get_axis("ui_up", "ui_down") * SPEED * delta
	move = Vector2(h_spd, v_spd)
	
	var discs = get_tree().get_nodes_in_group("Disc")
	disc_in_air = false
	for disc in discs:
		if !disc.grounded:
			disc_in_air = true
			stuck = true
			
	if move and stuck and !disc_in_air:
		stuck = false
		reset()
	
	if charging or throwing: return
	position += move

func set_spin():
	if Input.is_action_just_pressed("ui_left"):
		spin -= 1
	if Input.is_action_just_pressed("ui_right"):
		spin += 1

func throw():
	if discs <= 0: return
	discs -= 1
	var cam = get_tree().get_first_node_in_group("Camera")
	var disc = DISC.instantiate()
	disc.position = position
	disc.dir = (mouse_pos - Vector2(600, 300)).normalized()
	disc.power = min(100,power)
	disc.spin = spin
	get_tree().root.add_child(disc)
	throwing = true

func reset():
	throwing = false
	charging = false
	power = 0
	spin = 0
