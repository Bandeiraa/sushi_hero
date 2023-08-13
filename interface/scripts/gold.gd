extends Label
class_name GoldLabel

func update_gold_amount(_new_amount: float) -> void:
	text = "$ " + str(_new_amount)
