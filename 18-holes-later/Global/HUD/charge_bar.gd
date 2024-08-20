extends ProgressBar

var cooldown = 1

func _process(_delta):
	value = max(0, value-cooldown)
