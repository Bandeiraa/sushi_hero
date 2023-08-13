extends BaseBody
class_name ClientBody

var is_upset: bool = false
var is_eating: bool = false

@export_category("Objects")
@export var _client: Client = null
@export var _animation: AnimationPlayer = null

func _ready() -> void:
	initialize()
	
	
func initialize() -> void:
	_animation.connect(
		"animation_finished", 
		Callable(self, "_on_animation_finished")
	)
	
	
func animate(_velocity: Vector3) -> void:
	if _velocity:
		_animation.play("Walk")
		return
		
	_animation.play("Idle")
	
	
func animate_action(_action: String, _rotation: float = PI) -> void:
	rotation.y = _rotation
	_animation.play(_action)
	
	match _action:
		"Sitting_Eating":
			is_eating = true
			globals.spawn_sfx("res://musics/sfx/assets/eat.mp3", self)
			
			
func _on_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"Sitting_Start":
			if _client.on_table:
				recipes.order_random_food(_client)
				
			_animation.play("Sitting_Idle")
			
		"Sitting_End":
			if is_eating:
				_client.update_state("go_away", Vector3.ZERO, Vector3(0, 0, -65))
				is_eating = false
				return
				
			if not is_eating and is_upset:
				_client.update_state("go_away", Vector3.ZERO, Vector3(0, 0, -65))
				return
				
			if _client.on_sofa:
				_client.update_state("seek_sofa")
				
				
func _on_eat_timer_timeout() -> void:
	_animation.play("Sitting_End")
