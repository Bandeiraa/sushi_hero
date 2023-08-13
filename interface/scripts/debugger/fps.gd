extends Label
class_name DebuggerFps

func _physics_process(_delta: float) -> void:
	text = str(Engine.get_frames_per_second())  + " - Fps" 
