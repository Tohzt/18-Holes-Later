extends Entity

@onready var Hand = $Hand

const MAX_POWER = 20

func _ready():
	#CollisionMask : CollisionShape3D
	#AnimController : AnimatedSprite3D
	#StateController : Node
	super._ready()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()
