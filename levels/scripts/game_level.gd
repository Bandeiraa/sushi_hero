extends Node3D
class_name GameLevel

const _LEVEL_ENVIRONMENT: String = "res://levels/resources/world_environment.tres"

@export_category("Objects")
@export var _environment: WorldEnvironment = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_environment.environment = load(_LEVEL_ENVIRONMENT)
