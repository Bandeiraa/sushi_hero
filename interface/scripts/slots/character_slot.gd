extends BaseSlot
class_name CharacterSlot

func _on_send_button_pressed() -> void:
	match globals.current_container:
		"oven":
			get_tree().call_group("oven_container", "update_interactable", "add", _item)
			
		"fridge":
			get_tree().call_group("fridge_container", "update_interactable", "add", _item)
			
		"chopping":
			get_tree().call_group("cutting_container", "update_interactable", "add", _item)
			
	get_tree().call_group("character_inventory", "update_item", _item["item_name"], "decrease")
