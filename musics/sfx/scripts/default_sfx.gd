extends AudioStreamPlayer3D
class_name DefaultSFX

func _ready() -> void:
	play()
	
	
func _on_sfx_finished() -> void:
	queue_free()
