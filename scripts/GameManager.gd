# Guarda vidas, puntaje
# Decide cuándo hay game_over
# Informa si se debe spawnear el boss
# Persiste (por ser singleton/autoload)

extends Node

@export var boss_scene: PackedScene
var player: Node2D = null

signal game_over
signal lives_changed
signal score_changed

var lives := 3
var score := 0
var is_game_over := false
var boss_spawned = false

func set_player(p):
	player = p
	
func reduce_life(amount: int = 1):
	lives -= amount
	print("❤️ Vidas restantes:", lives)
	emit_signal("lives_changed", lives)
	
	if lives <= 0 and not is_game_over:
		is_game_over = true
		emit_signal("game_over")

func add_points(amount: int):
	if is_game_over:
		return
	
	score += amount
	emit_signal("score_changed", score)
	
	if score >= 100 and not boss_spawned:
		spawn_boss()
		boss_spawned = true

func spawn_boss():
	if boss_scene:
		var boss_instance = boss_scene.instantiate()
		get_tree().current_scene.add_child(boss_instance)
		
		if player:
			boss_instance.set_target(player)
			var directions = ["left", "right", "top", "bottom"]
			var random_direction = directions[randi() % directions.size()]
			print("direction: ", random_direction)
			boss_instance.set_spawn_direction(random_direction) # 👈🏻 luego llama el método
		
		else:
			print("❌ Player no asignado en GameManager")
