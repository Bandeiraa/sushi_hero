extends MeshInstance3D
class_name Sofa

var _offset: Vector3 = Vector3(0, 0.25, 0.02)
var _is_available: bool = true

func has_available_slot(_entity) -> void:
	if _is_available:
		_entity.update_state("walking", _offset, global_position)
		change_available_state(false)
		return
		
	_entity.update_state("seek_sofa")
	
	
func change_available_state(_state: bool) -> void:
	_is_available = _state
