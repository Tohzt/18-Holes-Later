extends VBoxContainer

@onready var h_slider = $H_Slider
@onready var v_slider = $V_Slider

func _ready():
	h_slider.value = Global.Settings.MOUSE_H_SENSITIVITY
	v_slider.value = Global.Settings.MOUSE_V_SENSITIVITY

func _on_h_slider_value_changed(value):
	print(Global.Settings.MOUSE_H_SENSITIVITY)
	Global.Settings.MOUSE_H_SENSITIVITY = value

func _on_v_slider_value_changed(value):
	Global.Settings.MOUSE_V_SENSITIVITY = value
