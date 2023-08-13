extends HBoxContainer
class_name TruckSlot

var parent = null
var _item: Dictionary = {}

@export_category("Objects")
@export var _item_name: Label = null
@export var _item_price: Label = null
@export var _item_texture: TextureRect = null

func add_item(_new_item: Dictionary) -> void:
	_item = _new_item
	_item_price.text = "PRICE - $" + str(_item["price"])
	_item_name.text = "ITEM - " + _item["item_name"].capitalize()
	_item_texture.texture = load(_item["item_texture"])
	
	
func get_item() -> Dictionary:
	return _item
	
	
func _on_send_button_pressed() -> void:
	parent.update_list_slot(_item)
