# Guarda vidas, puntaje
# Decide cuándo hay game_over
# Informa si se debe spawnear el boss
# Persiste (por ser singleton/autoload)

extends Node

@export var boss_scene: PackedScene

var player: Node2D = null
var sfx_player: AudioStreamPlayer2D = null
var music_player: AudioStreamPlayer = null

signal game_over
signal lives_changed
signal score_changed

var lives := 3
var score := 0
var is_game_over := false
var next_boss_score := 100

func set_player(p):
	player = p

func set_sfx_player(p_sfx_player: AudioStreamPlayer2D):
	sfx_player = p_sfx_player

func set_music_player(p_music_player: AudioStreamPlayer):
	music_player = p_music_player
	
func reduce_life(amount: int = 1):
	lives -= amount
	print("❤️ Vidas restantes:", lives)
	emit_signal("lives_changed", lives)
	
	if lives <= 0 and not is_game_over:
		is_game_over = true
		emit_signal("game_over")

func add_points(amount: int):
	# print('adding...', amount)
	if is_game_over:
		return
	
	score += amount
	emit_signal("score_changed", score)
	
	if score >= next_boss_score:
		spawn_boss()
		next_boss_score += Global.ADD_TO_BOSS_SCORE

func spawn_boss():
	if boss_scene:
		var boss_instance = boss_scene.instantiate()
		get_tree().current_scene.add_child(boss_instance)
		
		if player:
			boss_instance.set_target(player)
			var directions = ["left", "right", "top", "bottom"]
			var random_direction = directions[randi() % directions.size()]
			# print("direction: ", random_direction)
			boss_instance.set_spawn_direction(random_direction) # 👈🏻 luego llama el método
		
		else:
			print("❌ Player no asignado en GameManager")

func play_sfx(sfx_name: String):
	if not sfx_player:
		print("SFXPlayer no asignado.")
		return
	
	var sfx = {
		"click_enemy": preload("res://assets/sounds/click_enemy.wav"),
		"click_boss": preload("res://assets/sounds/click_boss.wav")
	}
	
	if sfx.has(sfx_name):
		sfx_player.stream = sfx[sfx_name]
		sfx_player.play()
		
func play_music(music_name: String):
	var music = {
		"main_theme": preload("res://assets/music/bg_music.ogg"),
		#"boss_theme": preload("res://assets/music/boss_theme.ogg"),
	}
	
	if music.has(music_name):
		music_player.stream = music[music_name]
		music_player.play()
	else:
		print("Música no encontrada:", music_name)
