extends CharacterBody3D
class_name BaseCharacter

const _SFX: PackedScene = preload("res://musics/sfx/scenes/default_sfx.tscn")

const _NORMAL_SPEED: float = 5.0
const _SPRINT_SPEED: float = 9.0
const _JUMP_VELOCITY: float = 4.5

var current_entity: InteractableObject = null

var _last_food: String = ""

var _last_prepared_ingredient: String = ""
var _last_prepared_ingredient_amount: int = 0

var is_freezed: bool = false

var _current_speed: float
var can_interact: bool = true
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_category("Variables")
@export var gold: int = 0

@export_category("Objects")
@export var _body: Node3D = null
@export var inventory: Node = null
@export var _spring_arm_offset: Node3D = null
@export var _food_feedback: MeshInstance3D = null

func _ready() -> void:
	globals.character = self
	recipes.character_ref = self
	get_tree().call_group("gold_label", "update_gold_amount", gold)
	
	
func update_gold(_amount: int, _type: String) -> void:
	match _type:
		"increase":
			gold += _amount
			
		"decrease":
			gold -= _amount
			
	get_tree().call_group("gold_label", "update_gold_amount", gold)
	
	
func _physics_process(_delta: float) -> void:
	if is_freezed:
		return
		
	if not is_on_floor():
		velocity.y -= _gravity * _delta
		
	#_jump()
	_move()
	move_and_slide()
	_body.animate(velocity)
	
	
#func _jump() -> void:
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = _JUMP_VELOCITY
#
#
func _move() -> void:
	var _input_direction: Vector2 = (
		Input.get_vector(
			"move_left", "move_right", 
			"move_forward", "move_backward"
		)
	)
	
	var _direction: Vector3 = transform.basis * Vector3(
		_input_direction.x, 0, _input_direction.y
	).normalized()
	
	is_running()
	_direction = _direction.rotated(Vector3.UP, _spring_arm_offset.rotation.y)
	
	if _direction:
		velocity.x = _direction.x * _current_speed
		velocity.z = _direction.z * _current_speed
		_body.apply_rotation(velocity)
		return
		
	velocity.x = move_toward(velocity.x, 0, _current_speed)
	velocity.z = move_toward(velocity.z, 0, _current_speed)
	
	
func is_running() -> bool:
	if Input.is_action_pressed("shift"):
		_current_speed = _SPRINT_SPEED
		return true
		
	_current_speed = _NORMAL_SPEED
	return false
	
	
func chop(_prepared_ingredient: String, _amount: int) -> void:
	can_interact = false
	_last_prepared_ingredient_amount = _amount
	_last_prepared_ingredient = _prepared_ingredient
	
	_food_feedback.get_node("FrontTexture").texture = load(
		ingredients.ingredients_dict[_prepared_ingredient]["item_texture"]
	)
	
	_food_feedback.get_node("BackTexture").texture = load(
		ingredients.ingredients_dict[_prepared_ingredient]["item_texture"]
	)
	
	_body.is_chopping = true
	_body.animate(velocity)
	set_physics_process(false)
	_spring_arm_offset.can_rotate = true
	_body.get_node("Armature/Skeleton3D/Knife").show()
	
	
func on_chop_finished() -> void:
	freeze(false)
	_body.is_chopping = false
	set_physics_process(true)
	_body.get_node("Armature/Skeleton3D/Knife").hide()
	_food_feedback.get_node("Animation").play("show_ingredient")
	globals.spawn_sfx("res://musics/sfx/assets/interactable_pop.mp3", self)
	
	
func cook(_food: String) -> void:
	_last_food = _food
	can_interact = false
	_food_feedback.get_node("FrontTexture").texture = load(
		recipes.recipes_dict[_food]["item_texture"]
	)
	
	_food_feedback.get_node("BackTexture").texture = load(
		recipes.recipes_dict[_food]["item_texture"]
	)
	
	_body.is_cooking = true
	_body.animate(velocity)
	set_physics_process(false)
	_spring_arm_offset.can_rotate = true
	_body.get_node("Armature/Skeleton3D/Pan").show()
	
	
func on_cook_finished() -> void:
	freeze(false)
	_body.is_cooking = false
	set_physics_process(true)
	_body.get_node("Armature/Skeleton3D/Pan").hide()
	_food_feedback.get_node("Animation").play("show")
	globals.spawn_sfx("res://musics/sfx/assets/interactable_pop.mp3", self)
	
	
func change_position(_position: Vector3, _rotation: float) -> void:
	global_position = _position
	_body.rotation.y = _rotation
	
	
func freeze(_state: bool) -> void:
	_body._animation.play("Idle")
	Input.mouse_mode = globals.mouse_mode[_state]
	_spring_arm_offset.can_rotate = not _state
	is_freezed = _state
	
	
func _on_food_feedback_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"show":
			var _item: Dictionary = {}
			_item[_last_food] = {
				"item_amount": 1,
				"item_name": _last_food,
				"item_texture": recipes.recipes_dict[_last_food]["item_texture"],
				"price": recipes.recipes_dict[_last_food]["price"]
			}
			
			inventory.add_item(_item[_last_food])
			
		"show_ingredient":
			for i in _last_prepared_ingredient_amount:
				var _item: Dictionary = {}
				_item[_last_prepared_ingredient] = {
					"item_amount": 1,
					"item_name": _last_prepared_ingredient,
					"item_texture": ingredients.ingredients_dict[
						_last_prepared_ingredient
					]["item_texture"]
				}
				
				inventory.add_item(_item[_last_prepared_ingredient])
				
	can_interact = true
	if current_entity != null:
		current_entity.can_interact(true, self)
		
		
func _spawn_sfx(_path: String, _volume: float = 0) -> void:
	globals.spawn_sfx(_path, self, _volume)
