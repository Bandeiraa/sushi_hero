extends Control
class_name BaseContainer

const _CHARACTER_SLOT: PackedScene = preload("res://interface/scenes/slots/character_slot.tscn")
const _INTERACTABLE_SLOT: PackedScene = preload("res://interface/scenes/slots/interactable_slot.tscn")

var _interactable = null

@export_category("Objects")
@export var _interactable_container: VBoxContainer = null
@export var _character_container: VBoxContainer = null

func update_interactable(_type: String, _item: Dictionary, _update_type: String = "increase") -> void:
	match _type:
		"add":
			for children in _interactable_container.get_children():
				var _old_item: Dictionary = children.get_item()
				if _old_item["item_name"] == _item["item_name"]:
					update_interactable("update", _item)
					return
					
			var _new_slot = _INTERACTABLE_SLOT.instantiate()
			_interactable_container.add_child(_new_slot)
			_new_slot.add_item(_item)
			
		"update":
			for children in _interactable_container.get_children():
				var _children_item: Dictionary = children.get_item()
				if _children_item["item_name"] == _item["item_name"]:
					children.update_item(_update_type)
					
					
func update_character(
		_type: String, 
		_item: Dictionary, 
		_update_type: String = "increase"
	) -> void:
		
	match _type:
		"add":
			var _new_slot: CharacterSlot = _CHARACTER_SLOT.instantiate()
			_character_container.add_child(_new_slot)
			_new_slot.add_item(_item)
			
		"update":
			for children in _character_container.get_children():
				var _children_item: Dictionary = children.get_item()
				if _children_item["item_name"] == _item["item_name"]:
					children.update_item(_update_type)
					
					
func _process(_delta: float) -> void:
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_cancel") and visible:
		_interactable.change_state(true)
		_close()
		
		
func _close() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = globals.mouse_mode[visible]
	
	
func display(_target, _visibility: bool) -> void:
	if _visibility:
		_change_current_container()
		
	_interactable = _target
	visible = _visibility
	
	
func _change_current_container() -> void:
	pass
