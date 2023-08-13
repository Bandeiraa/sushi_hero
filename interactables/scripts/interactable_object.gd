extends Node3D
class_name InteractableObject

var _can_interact: bool = false
var _character_ref: BaseCharacter = null

@export_category("Objects")
@export var _feedback: MeshInstance3D = null

func can_interact(_state: bool, _body: BaseCharacter = null) -> void:
	if _state:
		globals.spawn_sfx("res://musics/sfx/assets/interactable_pop.mp3", self)
		
	_feedback.visible = _state
	_character_ref = _body
	_can_interact = _state
	
	
func _physics_process(_delta: float) -> void:
	if _character_ref == null:
		return
		
	if _can_interact and Input.is_action_just_pressed("interact"):
		change_state(false)
		_interact()
		
		
func _interact() -> void:
	pass
	
	
func change_state(_state: bool) -> void:
	if _character_ref != null:
		_character_ref.freeze(not _state)
		
		if _character_ref.can_interact:
			_can_interact = _state
			_feedback.visible = _state
