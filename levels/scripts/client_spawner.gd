extends Node3D
class_name ClientSpawner

const _CLIENTS: Array = [
	preload("res://characters/scenes/character/panda.tscn"),
	preload("res://characters/scenes/character/rabbit_bald.tscn"),
	preload("res://characters/scenes/character/rabbit_blond.tscn"),
	preload("res://characters/scenes/character/rabbit_cyan.tscn"),
	preload("res://characters/scenes/character/rabbit_grey.tscn"),
	preload("res://characters/scenes/character/rabbit_purple.tscn")
]

@export_category("Objects")
@export var _clients: Node3D = null
@export var _spawn_timer: Timer = null

func _ready() -> void:
	_spawn_client()
	_spawn_timer.start()
	
	
func _on_spawn_cooldown_timeout() -> void:
	_spawn_timer.start()
	_spawn_client()
	
	
func _spawn_client() -> void:
	var _client = _CLIENTS[randi() % _CLIENTS.size()].instantiate()
	_clients.add_child(_client)
