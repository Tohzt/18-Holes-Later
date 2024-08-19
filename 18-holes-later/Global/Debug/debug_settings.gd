extends Node
class_name DebugSettings

@export var draw_debug_lines: bool = false
# Add other settings as needed
@export var some_other_setting: int = 0
@export var another_setting: String = "default"

func set_draw_debug_lines(yes_no: bool = false) -> void:
	draw_debug_lines = yes_no
