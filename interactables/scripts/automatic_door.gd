extends Area3D
class_name AutomaticDoor

const _SFX: PackedScene = preload("res://musics/sfx/scenes/default_sfx.tscn")

var _is_open: bool = false
var _character_ref: BaseCharacter = null

@export_category("Objects")
@export var _door_timer: Timer = null
@export var _animation: AnimationPlayer = null

func _on_body_entered(_body) -> void:
	if _body is BaseCharacter:
		_character_ref = _body
		
		if not _is_open:
			globals.spawn_sfx("res://musics/sfx/assets/automatic_door.mp3", self)
			_animation.play("open")
			
			
func _on_body_exited(_body) -> void:
	if _body is BaseCharacter:
		_character_ref = null
		
		
func _on_door_cooldown_timeout() -> void:
	if _character_ref == null:
		globals.spawn_sfx("res://musics/sfx/assets/automatic_door.mp3", self)
		_animation.play("close")
		_is_open = false
		return
		
	_door_timer.start()
	
	
func _on_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"open":
			_is_open = true
			_door_timer.start()
			
			
func _spawn_sfx(_path: String, _volume: float = 0) -> void:
	var _sfx: DefaultSFX = _SFX.instantiate()
	_sfx.stream = load(_path)
	_sfx.volume_db = _volume
	add_child(_sfx)
