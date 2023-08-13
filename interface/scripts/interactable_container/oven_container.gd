extends BaseContainer
class_name OvenContainer

func _on_cook_button_pressed() -> void:
	var _ingredients: Dictionary = {}
	for _children in _interactable_container.get_children():
		var _item: Dictionary = _children.get_alt_item()
		
		_ingredients[_item["item_name"]] = {
			"name": _item["item_name"],
			"amount": _item["item_amount"]
		}
		
	var _recipes: Dictionary = {}
	for _recipe in recipes.recipes_dict:
		for _ingredient in recipes.recipes_dict[_recipe]["ingredients"]:
			if not _recipes.has(_recipe):
				_recipes[_recipe] = {}
				
			_recipes[_recipe][_ingredient] = {
				"name": _ingredient,
				"amount": recipes.recipes_dict[_recipe]["ingredients"][_ingredient]["amount"]
			}
			
	for _r in _recipes:
		if _recipes[_r] == _ingredients:
			for _children in _interactable_container.get_children():
				var _amount: int = _children.get_alt_item()["item_amount"]
				for _i in _amount:
					update_interactable("update", _children.get_item(), "decrease")
					
			globals.character.cook(_r)
			_close()
			return
			
			
func _change_current_container() -> void:
	globals.current_container = "oven"
