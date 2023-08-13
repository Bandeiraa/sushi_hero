extends CanvasLayer
class_name TransitionScreen

@export_category("Objects")
@export var _animation: AnimationPlayer = null

func fade_in() -> void:
	_animation.play("show")
	
	
func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name == "show":
		get_tree().reload_current_scene()
		_animation.play("hide")
