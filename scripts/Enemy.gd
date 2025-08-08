extends Area2D

@export var base_speed: float = 100.0
@export var speed: float =	base_speed
@export var points: int = 50
@export var enemy_type: int = 1 # 1: puntos, 2: quita vida
@export var damage: int = 0 # 0: puntos, 1: vidas

var direction = Vector2.ZERO
var player_position = Vector2.ZERO
	
func _ready():
	update_speed()
	 # Calcular dirección hacia el jugador, que está en el centro
	player_position = get_viewport_rect().size / 2
	direction = (player_position - position).normalized()
	
	# Conectar la señal de colisión
	connect("area_entered", Callable(self, "_on_area_entered"))
	
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
	# Enemigo colisiona con el jugador
	if enemy_type == 1:
		GameManager.add_points(-5)
	elif enemy_type == 2:
		GameManager.reduce_life()
	queue_free() # el enemigo desaparece
	#if area.name == "Player":
	#	queue_free() # el enemigo desaparece
	#	area.take_damage() # el jugador recibe daño (ver paso siguiente)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GameManager.add_points(points)
		queue_free() # Enemigo destruido

func update_speed():
	var bonus = GameManager.score / 100 * 20 # Cada 100 puntos +20 de velocidad
	speed = base_speed + bonus
