extends InteractableObject
class_name Fridge

func _interact() -> void:
	globals.spawn_sfx("res://musics/sfx/assets/open_door.mp3", self)
	get_tree().call_group("fridge_container", "display", self, true)
