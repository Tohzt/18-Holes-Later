extends ProgressBar

var cooldown = 1

func _process(_delta):
	printt(Global.Player.charge_power, value)
	value = clamp(Global.Player.charge_power, 0, 100)
	#value = max(0, value-cooldown)
