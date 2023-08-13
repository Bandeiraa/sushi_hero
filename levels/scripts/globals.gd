extends Node

const _SFX: PackedScene = preload("res://musics/sfx/scenes/default_sfx.tscn")

var mouse_mode: Dictionary = {
	false: Input.MOUSE_MODE_CAPTURED,
	true: Input.MOUSE_MODE_VISIBLE
}

var character: CharacterBody3D = null
var interface: CanvasLayer = null

var current_container: String = ""
var reputation: int = 50

func update_reputation(_value: float = 0, _satisfied: bool = false) -> void:
	if _satisfied:
		if _is_between(0, 40, _value):
			reputation += randi_range(1, 3)
			
		if _is_between(40, 80, _value):
			reputation += randi_range(2, 4)
			
		if _is_between(80, 120, _value):
			reputation += randi_range(4, 8)
			
		interface.update_reputation(reputation)
		return
		
	reputation -= randi_range(5, 10)
	interface.update_reputation(reputation)
	
	
func _is_between(_min: int, _max: int, _value: float) -> bool:
	if _value >= _min and _value < _max:
		return true
		
	return false
	
	
func reset_reputation() -> void:
	reputation = 50
	
	
func spawn_sfx(_path: String, _entity, _volume_db: float = 0.0) -> void:
	var _sfx = _SFX.instantiate()
	_sfx.volume_db = _volume_db
	_sfx.stream = load(_path)
	_entity.add_child(_sfx)
