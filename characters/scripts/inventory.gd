extends Node
class_name CharacterInventory

var _inventory: Dictionary = {}
var _inventory_aux: Dictionary = {}

func add_item(_item: Dictionary) -> void:
	if _inventory_aux.has(_item["item_name"]):
		update_item(_item["item_name"], "increase")
		return
		
	_inventory[_item["item_name"]] = _item
	_inventory_aux[_item["item_name"]] = _inventory[_item["item_name"]].duplicate(true)
	get_tree().call_group("oven_container", "update_character", "add", _item)
	get_tree().call_group("fridge_container", "update_character", "add", _item)
	get_tree().call_group("cutting_container", "update_character", "add", _item)
	
	
func update_item(_item_name: String, _type: String) -> void:
	match _type:
		"increase":
			_inventory_aux[_item_name]["item_amount"] += 1
			get_tree().call_group("oven_container", "update_character", "update", _inventory_aux[_item_name])
			get_tree().call_group("fridge_container", "update_character", "update", _inventory_aux[_item_name])
			get_tree().call_group("cutting_container", "update_character", "update", _inventory_aux[_item_name])
			
		"decrease":
			_inventory_aux[_item_name]["item_amount"] -= 1
			get_tree().call_group("oven_container", "update_character", "update", _inventory_aux[_item_name], "decrease")
			get_tree().call_group("fridge_container", "update_character", "update", _inventory_aux[_item_name], "decrease")
			get_tree().call_group("cutting_container", "update_character", "update", _inventory_aux[_item_name], "decrease")
			if _inventory_aux[_item_name]["item_amount"] == 0:
				remove_item(_item_name)
				return
				
				
func remove_item(_item_name: String) -> void:
	_inventory.erase(_item_name)
	_inventory_aux.erase(_item_name)
	
	
func get_inventory() -> Dictionary:
	return _inventory
	
	
func get_inventory_aux() -> Dictionary:
	return _inventory_aux
