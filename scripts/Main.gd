# Instancia cosas en pantalla
# Conecta timers
# Le dice al GameManager quién es el jugador
# Se reinicia cuando cambias de escena

extends Node2D

@onready var enemy_scene = preload("res://scenes/enemies/Enemy.tscn")
@onready var game_manager = $GameManager

var player_scene = preload("res://scenes/player/Player.tscn")
var player_instance

func _ready():
	player_instance = player_scene.instantiate()
	player_instance.name = "Player"  
	add_child(player_instance)

	GameManager.set_player(player_instance)
	GameManager.set_sfx_player($SFXPlayer)
	GameManager.set_music_player($MusicPlayer)
	
	GameManager.play_music("main_theme")
	
func _on_enemy_spawn_timer_timeout() -> void:
	if GameManager.is_game_over:
		return
	
	var enemy = enemy_scene.instantiate()
	var edges = [
		Global.EDGE_LEFT,
		Global.EDGE_RIGHT,
		Global.EDGE_TOP,
		Global.EDGE_BOTTOM
	]
	
	enemy.spawn_edge = edges.pick_random()
	add_child(enemy)
	# print("Enemy created")
