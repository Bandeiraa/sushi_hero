extends Control
class_name BaseSlot

var _item: Dictionary = {}
var _new_instance: Dictionary = {}

@export_category("Objects")
@export var _item_name: Label = null
@export var _item_amount: Label = null
@export var _item_texture: TextureRect = null

func add_item(_new_item: Dictionary) -> void:
	_item = _new_item
	
	_item["item_amount"] = 1
	_new_instance = _item.duplicate(true)
	
	update_item_amount()
	_item_name.text = "ITEM - " + _item["item_name"].capitalize()
	_item_texture.texture = load(_item["item_texture"])
	
	
func update_item(_type: String) -> void:
	match _type: 
		"increase":
			_new_instance["item_amount"] += 1
			update_item_amount()
			
		"decrease":
			_new_instance["item_amount"] -= 1
			if _new_instance["item_amount"] == 0:
				remove_item()
				return
				
			update_item_amount()
			
			
func remove_item() -> void:
	queue_free()
	
	
func update_item_amount() -> void:
	_item_amount.text = "AMOUNT - " + str(_new_instance["item_amount"]) + "x" 
	
	
func get_item() -> Dictionary:
	return _item
	
	
func get_alt_item() -> Dictionary:
	return _new_instance
