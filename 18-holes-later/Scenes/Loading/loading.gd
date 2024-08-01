extends Control


var loading_status : int
var progress : Array[float]

@onready var progress_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	printt("Loading... ", Global.Scene)
	# Request to load the target scene:
	ResourceLoader.load_threaded_request(Global.Scene)
	
func _process(_delta: float) -> void:
	# Update the status:
	loading_status = ResourceLoader.load_threaded_get_status(Global.Scene, progress)
	
	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(Global.Scene))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print_debug("Error. Could not load Resource")
