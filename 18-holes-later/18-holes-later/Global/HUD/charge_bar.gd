extends ProgressBar

func _process(_delta):
	value = clamp(Global.Player.charge_power, 0, 100)
