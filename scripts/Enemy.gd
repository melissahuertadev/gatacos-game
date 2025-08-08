extends Area2D

@export var speed = 100.0
var direction = Vector2.ZERO
var player_position = Vector2.ZERO

func _ready():
	 # Calcular dirección hacia el jugador, que está en el centro
	player_position = get_viewport_rect().size / 2
	direction = (player_position - position).normalized()
	
	# Conectar la señal de colisión
	connect("area_entered", Callable(self, "_on_area_entered"))
	
func _process(delta):
	position += direction * speed * delta
	# Si en el futuro se mueve:
	# var player = get_tree().get_root().get_node("Main/Player")
	# if player:
	#	var dir = (player.position - position).normalized()
	#	position += dir * speed * delta

func _on_area_entered(area):
	if area.name == "Player":
		print("El enemigo tocó al jugador")
		queue_free() # el enemigo desaparece
		area.take_damage() # el jugador recibe daño (ver paso siguiente)
