extends BaseSlot
class_name InteractableSlot

func _on_send_button_pressed() -> void:
	get_tree().call_group(
		"character_inventory", 
		"add_item", 
		_item
	)
	
	update_item("decrease")
