extends RigidBody3D


func _ready():
	# Connect the body_entered signal to our function
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# This function will be called when a collision occurs
	print("Collision detected with: ", body.name)
	self.axis_lock_angular_x = false
	self.axis_lock_angular_z = false
