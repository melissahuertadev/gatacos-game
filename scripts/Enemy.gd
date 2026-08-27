extends Area2D

@export var base_speed: float = 200.0
@export var speed: float =	base_speed
@export var points: int = 10
@export var enemy_type: int = 1 # 1: puntos, 2: quita vida
@export var damage: int = 0 # 0: puntos, 1: vidas
@export var spawn_edge: String = Global.EDGE_LEFT
@export var skin: String = "cream"

var direction = Vector2.ZERO
var player_position = Vector2.ZERO

	
func _ready():
	if not is_connected("area_entered", Callable(self, "_on_area_entered")):
		# Conectar la señal de colisión
		connect("area_entered", Callable(self, "_on_area_entered"))
	
	update_speed()
	set_random_skin()
	set_spawn_position()
	update_direction()
	update_animation()
	
func _process(delta):
	if GameManager.is_game_over:
		return  # Detener movimiento
	
	position += direction * speed * delta
	# Si en el futuro se mueve:
	# var player = get_tree().get_root().get_node("Main/Player")
	# if player:
	#	var dir = (player.position - position).normalized()
	#	position += dir * speed * delta

func _on_area_entered(area):
	#	print("ENEMY COLLIDED WITH:", area.name)
	if area.name != "Player":
		return  # Ignorar otras colisiones
	
	# Enemigo colisiona con el jugador
	if enemy_type == 1:
		GameManager.add_points(-5)
	elif enemy_type == 2:
		GameManager.reduce_life()
	
	queue_free() # el enemigo desaparece
	#if area.name == "Player":
	#	queue_free() # el enemigo desaparece
	#	area.take_damage() # el jugador recibe daño (ver paso siguiente)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GameManager.add_points(points)
		GameManager.play_sfx("click_enemy")
		queue_free() # Enemigo destruido

func update_speed():
	var bonus = (GameManager.score / 100.0) * 42 # Cada 100 puntos +20 de velocidad
	speed = base_speed + bonus

func set_random_skin():
	var skins = Global.ENEMY_SKINS
	skin = skins.pick_random()

func set_spawn_position():
	var screen_size = get_viewport_rect().size
	match spawn_edge:
		Global.EDGE_LEFT:
			position = Vector2(-50, randf_range(0, screen_size.y))
		Global.EDGE_RIGHT:
			position = Vector2(screen_size.x + 50, randf_range(0, screen_size.y))
		Global.EDGE_TOP:
			position = Vector2(randf_range(0, screen_size.x), -50)
		Global.EDGE_BOTTOM:
			position = Vector2(randf_range(0, screen_size.x), screen_size.y + 50)

func update_direction():
	# Calcular dirección hacia el jugador, que está en el centro
	player_position = get_viewport_rect().size / 2
	direction = (player_position - position).normalized()
	
func update_animation():
	match spawn_edge:
		Global.EDGE_LEFT:
			$AnimatedSprite2D.play(skin + "_walk_left")
		Global.EDGE_RIGHT:
			$AnimatedSprite2D.play(skin + "_walk_right")
		Global.EDGE_TOP:
			$AnimatedSprite2D.play(skin + "_walk_top")
		Global.EDGE_BOTTOM:
			$AnimatedSprite2D.play(skin + "_walk_bottom")
