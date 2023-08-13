extends InteractableObject
class_name RecipesSign

func _interact() -> void:
	get_tree().call_group("recipes", "display", self, true)
