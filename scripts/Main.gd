# Instancia cosas en pantalla
# Conecta timers
# Le dice al GameManager quién es el jugador
# Se reinicia cuando cambias de escena

extends Node2D

@onready var enemy_scene = preload("res://scenes/enemies/Enemy.tscn")
@onready var game_manager = $GameManager

var player_scene = preload("res://scenes/Player.tscn")
var player_instance

func _ready():
	player_instance = player_scene.instantiate()
	player_instance.name = "Player"  
	add_child(player_instance)

	GameManager.set_player(player_instance)
	
func _on_enemy_spawn_timer_timeout() -> void:
	if GameManager.is_game_over:
		return
	
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(0, randf_range(0, get_viewport_rect().size.y))
	add_child(enemy)
	# print("Enemy created")
