extends BaseBody
class_name CharacterBody

var is_enabled: bool = false

var is_holding: bool = false
var is_cooking: bool = false
var is_chopping: bool = false

@export_category("Objects")
@export var _character: BaseCharacter = null
@export var _animation: AnimationPlayer = null

@export var _cook_timer: Timer = null
@export var _chop_timer: Timer = null

func animate(_velocity: Vector3) -> void:
	if on_action():
		return
		
	if _velocity:
		if _character.is_running():
			_animation.play("Run" + _is_holding_object())
			return
			
		_animation.play("Walk" + _is_holding_object())
		return
		
	_animation.play("Idle" + _is_holding_object())
	
	
func on_action() -> bool:
	if is_chopping and not is_enabled:
		_animation.play("Chop_Start")
		is_enabled = true
		return true
		
	if is_cooking and not is_enabled:
		_animation.play("Pan_Start")
		is_enabled = true
		return true
		
	if is_cooking or is_chopping:
		return true
		
	return false
	
	
func _is_holding_object() -> String:
	if is_holding:
		return "_Holding"
		
	return ""
	
	
func _on_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"Pan_Start":
			_cook_timer.start()
			_animation.play("Pan")
			globals.spawn_sfx("res://musics/sfx/assets/fry.mp3", _character)
			
		"Chop_Start":
			_chop_timer.start()
			_animation.play("Chop")
			
		"Pan_End":
			is_enabled = false
			_character.on_cook_finished()
			
		"Chop_End":
			is_enabled = false
			_character.on_chop_finished()
			
			
func _on_cook_timer_timeout() -> void:
	_animation.play("Pan_End")
	
	
func _on_chop_timer_timeout():
	_animation.play("Chop_End")
