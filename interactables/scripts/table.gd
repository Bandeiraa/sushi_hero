extends Area3D
class_name Table

const _STOOL: PackedScene = preload("res://furniture/environment/stool.tscn")

var _chair_positions: Array = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(-2, 0, 0),
	Vector3(0, 0, -2)
]

var _chair_offset_positions: Array = [
	Vector3(0, 0, 0.4),
	Vector3(0.4, 0, 0),
	Vector3(-0.4, 0, 0),
	Vector3(0, 0, -0.4)
]

var _angle_rotation: Array = [
	0,
	PI/2,
	-PI + PI/2,
	PI
]

var _offset: Vector3 = Vector3.ZERO

@export_category("Variables")
@export var _chair_amount: int = 1
@export var _is_available: bool = true

@export_category("Objects")
@export var _stools: Node3D = null

func _ready() -> void:
	for _chair in _chair_amount:
		var _new_chair = _STOOL.instantiate()
		_new_chair.transform.origin = _chair_positions[_chair]
		_stools.add_child(_new_chair)
		
		
func is_available(_entity) -> void:
	if not _is_available:
		_entity.update_state("seek_table")
		return
		
	var _index: int = randi() % _stools.get_child_count()
	var _rotation: float = _angle_rotation[_index]
	
	change_available_state(false)
	_offset = _chair_positions[_index] - _chair_offset_positions[_index]
	_entity.update_state("walking", _offset, global_position, _rotation)
	
	
func change_available_state(_state: bool) -> void:
	_is_available = _state
