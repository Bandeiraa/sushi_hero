extends CharacterBody3D
class_name Client

const _NORMAL_SPEED: float = 3.0

var _food: Dictionary = {}
var _character_ref: BaseCharacter = null

var _rotation: float = PI
var _seeking_for: String = ""

var _table_index: int = -1
var _tables_list: Array = []

var _sofa_index: int = -1
var _sofas_list: Array = []

var _object_position: Vector3 = Vector3.ZERO
var _target_position: Vector3 = Vector3.ZERO
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _time_left: float
var _satisfied: bool = false

var on_sofa: bool = false
var on_table: bool = false

@export_category("Objects")
@export var _armature: Node3D = null
@export var _client_feedback: MeshInstance3D = null
@export var _navigation_agent: NavigationAgent3D = null

@export var _eat_timer: Timer = null
@export var _wait_timer: Timer = null

func _ready() -> void:
	hide()
	call_deferred("client_setup")
	
	
func client_setup() -> void:
	show()
	_navigation_agent.path_desired_distance = 0.5
	_navigation_agent.target_desired_distance = 0.5
	# Wait for the 1st frame, so the actor can sync with the navigation terrain
	await get_tree().physics_frame
	
	if _tables_list.is_empty():
		for _table in get_tree().get_nodes_in_group("table"):
			_tables_list.append(_table)
			
	if _sofas_list.is_empty():
		for _sofa in get_tree().get_nodes_in_group("sofa"):
			_sofas_list.append(_sofa)
			
			
	_sofa_index = -1
	_table_index = -1
	_seek_slot("table")
	
	
func update_state(
		_new_state: String, 
		_offset: Vector3 = Vector3.ZERO, 
		_position: Vector3 = Vector3.ZERO,
		_optional_rotation: float = PI
	) -> void:
		
	match _new_state:
		"seek_table":
			_seek_slot("table")
			
		"seek_sofa":
			_seek_slot("sofa")
			
		"walking":
			_target_position = _position
			_rotation = _optional_rotation
			_object_position = _position + _offset
			_set_movement_target(_target_position)
			
		"go_away":
			if _satisfied:
				_tables_list[_table_index].get_node("Plate").get_node(_food["name"].to_pascal_case()).hide()
				_tables_list[_table_index].change_available_state(true)
				
			_update_food_state({})
			_seeking_for = "way_out"
			_target_position = _position
			_set_movement_target(_target_position)
			
			
func _seek_slot(_furniture: String) -> void:
	_seeking_for = _furniture
	
	match _furniture:
		"table":
			_table_index += 1
			
			if _table_index == _tables_list.size() and on_sofa:
				update_state("go_away", Vector3.ZERO, Vector3(0, 0, -65))
				return
				
			if _table_index == _tables_list.size():
				_seek_slot("sofa")
				return
				
			_tables_list[_table_index].is_available(self)
			
		"sofa":
			_sofa_index += 1
			if _sofa_index == _sofas_list.size():
				update_state("go_away", Vector3.ZERO, Vector3(0, 0, -65))
				return
				
			_sofas_list[_sofa_index].has_available_slot(self)
			
			
func _set_movement_target(_position: Vector3) -> void:
	_navigation_agent.set_target_position(_position)
	
	
func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * _delta
		
	if (
		Input.is_action_just_pressed("interact") and 
		_character_ref != null and 
		_food != {}
	):
		_has_food()
		
	if _navigation_agent.is_navigation_finished():
		return
		
	var _current_position: Vector3 = global_position
	var _next_position: Vector3 = _navigation_agent.get_next_path_position()
	
	var _direction: Vector3 = (_next_position - _current_position).normalized()
	var _distance: float = global_position.distance_to(_target_position)
	
	match _seeking_for:
		"table":
			if _distance > 0 and _distance < 3:
				on_table = true
				_wait_timer.start()
				_seeking_for = "none"
				global_position = _object_position
				_target_position = _object_position
				_armature.animate_action("Sitting_Start", _rotation)
				globals.spawn_sfx("res://musics/sfx/assets/bell_ring.mp3", self, 10.0)
				return
				
		"sofa":
			if _distance > 0 and _distance < 2:
				on_sofa = true
				_wait_timer.start()
				_seeking_for = "none"
				global_position = _object_position
				_target_position = _object_position
				_armature.animate_action("Sitting_Start", _rotation)
				return
				
		"way_out":
			if _distance > 0 and _distance < 2:
				if _satisfied:
					globals.update_reputation(_time_left, _satisfied)
					queue_free()
					return
					
				globals.update_reputation()
				queue_free()
				return
				
		"none":
			return
			
	_navigation_agent.set_velocity(_direction * _NORMAL_SPEED)
	
	
func _on_navigation_agent_velocity_computed(_safe_velocity: Vector3) -> void:
	if on_table or on_sofa:
		return
		
	velocity.x = _safe_velocity.x
	velocity.z = _safe_velocity.z
	
	_armature.apply_rotation(velocity)
	_armature.animate(velocity)
	move_and_slide()
	
	
func configure_client_feedback(_item: Dictionary) -> void:
	_client_feedback.get_node("FrontTexture").texture = load(
		_item["item_texture"]
	)
	
	_client_feedback.get_node("BackTexture").texture = load(
		_item["item_texture"]
	)
	
	_update_food_state(_item)
	
	
func _update_food_state(_item: Dictionary) -> void:
	_food = _item
	if _item != {}:
		_client_feedback.show()
		return
		
	_client_feedback.hide()
	
	
func _on_interactable_area_body_entered(_body) -> void:
	if _body is BaseCharacter:
		_character_ref = _body
		
		
func _on_interactable_area_body_exited(_body) -> void:
	if _body is BaseCharacter:
		_character_ref = null
		
		
func _has_food() -> void:
	var _inventory: Dictionary = _character_ref.inventory.get_inventory_aux()
	for _item in _inventory:
		if _inventory[_item]["item_name"] == _food["name"]:
			_tables_list[_table_index].get_node("Plate").get_node(_food["name"].to_pascal_case()).show()
			var _item_price: int = _inventory[_item]["price"]
			_character_ref.update_gold(_item_price, "increase")
			globals.spawn_sfx("res://musics/sfx/assets/money.mp3", self)
			_character_ref.inventory.update_item(_inventory[_item]["item_name"], "decrease")
			_armature.animate_action("Sitting_Eating", _rotation)
			_time_left = _wait_timer.time_left
			_client_feedback.hide()
			_wait_timer.stop()
			_eat_timer.start()
			_satisfied = true
			
			
func _on_wait_timer_timeout() -> void:
	if on_sofa:
		on_sofa = false
		_table_index = -1
		_armature.animate_action("Sitting_End", _rotation)
		_sofas_list[_sofa_index].change_available_state(true)
		return
		
	on_table = false
	_update_food_state({})
	_armature.is_upset = true
	_armature.animate_action("Sitting_End", _rotation)
	_tables_list[_table_index].change_available_state(true)
