extends StaticBody3D

var wiggle = false
var wiggle_dur = 1.0
var wiggle_time = 0.0

func start_wiggle():
	wiggle = true
	wiggle_time = wiggle_dur

func _process(delta):
	if wiggle_time > 0:
		print("wiggle")
		wiggle_time -= delta
	else: 
		wiggle = false
		wiggle_time = 0.0
