extends Area3D
class_name InteractableArea

@export_category("Objects")
@export var _parent: Node3D = null

func _on_body_entered(_body) -> void:
	if _body is BaseCharacter:
		_body.current_entity = _parent
		if _body.can_interact:
			_parent.can_interact(true, _body)
			
			
func _on_body_exited(_body) -> void:
	if _body is BaseCharacter:
		_parent.can_interact(false)
		_body.current_entity = null
