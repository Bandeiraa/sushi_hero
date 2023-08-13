extends Control
class_name TruckContainer

const _LIST_SLOT: PackedScene = preload("res://interface/scenes/slots/list_slot.tscn")
const _TRUCK_SLOT: PackedScene = preload("res://interface/scenes/slots/truck_slot.tscn")

var _price: int = 0
var _interactable = null

@export_category("Variables")
@export var _amount: int = 10

@export_category("Objects")
@export var _truck_container: VBoxContainer = null
@export var _list_container: VBoxContainer = null
@export var _total: Label = null

func _ready() -> void:
	_refill_truck()
	
	
func _refill_truck() -> void:
	var _i: int = 0
	var _keys: Array = ingredients.ingredients_dict.keys()
	while _i < _amount:
		var _childrens: Array = []
		var _random_index: int = randi() % _keys.size()
		for _children in _truck_container.get_children():
			_childrens.append(_children.get_item()["item_name"])
			
		if  _childrens.has(ingredients.ingredients_dict[_keys[_random_index]]["item_name"]) :
			continue
			
		update_interactable("add", ingredients.ingredients_dict[_keys[_random_index]])
		_i += 1
		
		
func update_interactable(_type: String, _item: Dictionary, _update_type: String = "increase") -> void:
	match _type:
		"add":
			var _new_slot = _TRUCK_SLOT.instantiate()
			_truck_container.add_child(_new_slot)
			_new_slot.add_item(_item)
			_new_slot.parent = self
			
			
func update_list_slot(_item: Dictionary) -> void:
	update_price("increase", _item["price"])
	for _children in _list_container.get_children():
		if _children.get_item()["item_name"] == _item["item_name"]:
			_children.update_item("increase")
			return
			
	var _new_slot = _LIST_SLOT.instantiate()
	_list_container.add_child(_new_slot)
	_new_slot.add_item(_item)
	_new_slot.parent = self
	
	
func update_price(_type: String, _value: int) -> void:
	match _type:
		"increase":
			_price += _value
			
		"decrease":
			_price -= _value
			
	_total.text = "TOTAL - $" + str(_price)
	
	
func _on_buy_button_pressed() -> void:
	if globals.character == null:
		return
		
	if globals.character.gold >= _price:
		globals.character.update_gold(_price, "decrease")
		
		for _children in _list_container.get_children():
			var _item: Dictionary = _children.get_alt_item()
			for _i in _item["item_amount"]:
				get_tree().call_group("character_inventory", "add_item", _item)
				_children.update_item("decrease")
				
		_price = 0
		update_price("increase", 0)
		globals.spawn_sfx("res://musics/sfx/assets/money.mp3", _interactable)
		
		
func _process(_delta: float) -> void:
	if _interactable != null and visible:
		if _interactable._character_ref == null:
			_close()
			
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_cancel") and visible:
		_interactable.change_state(true)
		_close()
		
		
func _close() -> void:
	_clean()
	visible = false
	get_tree().paused = false
	Input.mouse_mode = globals.mouse_mode[visible]
	
	
func _clean() -> void:
	for _children in _truck_container.get_children():
		_children.queue_free()
		
	for _children in _list_container.get_children():
		_children.queue_free()
		
	_price = 0
	_refill_truck()
	update_price("increase", 0)
	
	
func display(_target, _visibility: bool) -> void:
	_interactable = _target
	visible = _visibility
