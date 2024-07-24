extends CharacterBody3D

@onready var animated_sprite_3d = $AnimatedSprite3D

# TODO: Get Gravity
const gravity = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move(Vector3.LEFT, 0)
	if !is_on_floor():
		velocity.y -= gravity
	move_and_collide(velocity)

func move(dir: Vector3, spd : float):
	velocity = dir * spd
	handle_animation()
	update_flip(dir.x)

func update_flip(x_dir):
	if !Global.Player: return
	if x_dir > Global.Player.position.x:
		animated_sprite_3d.flip_h = true
	else:
		animated_sprite_3d.flip_h = false

func handle_animation():
	if !is_on_floor():
		animated_sprite_3d.play("Fall")
	
	if velocity.x != 0 or velocity.y != 0:
		animated_sprite_3d.play("Walk")
	else:
		animated_sprite_3d.play("Idle")
