extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: Sprite2D = $HealthBar

@export var bar_sprites: Array[Texture2D] = []
@export var max_health := 5
@export var direction_from := "left" # Puede ser: "left", "right", "top", "bottom"
#@export var speed: float = 100.0

signal boss_died

var target: Node2D = null
var current_health := max_health

func _ready():
	# print("🟣 sprite es:", sprite)
	set_process(true)
	current_health = max_health
	update_health_bar()

func _process(delta):
	if GameManager.is_game_over:
		return
	if target:
		var target_direction = (target.global_position - global_position).normalized()
		global_position += target_direction * Global.speed * delta
#	else:
#		print("❌ target es null")
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		take_damage()

func set_target(t: Node2D):
	target = t
	# print("✅ Boss target asignado: ", target)
	
func set_spawn_direction(side: String):
	# print('Boss viene desde:', side)
	var screen_size = get_viewport_rect().size
	var random_pos = 0.0
	
	match side:
		"left":
			random_pos = randf_range(0, screen_size.y)
			position = Vector2(-50, random_pos)
			sprite.play("boss_enemy_left")
		"right":
			random_pos = randf_range(0, screen_size.y)
			position = Vector2(screen_size.x + 50, random_pos)
			sprite.play("boss_enemy_right")
		"top":
			random_pos = randf_range(0, screen_size.x)
			position = Vector2(random_pos, -50)
			sprite.play("boss_enemy_top")
		"bottom":
			random_pos = randf_range(0, screen_size.x)
			position = Vector2(random_pos, screen_size.y + 50)
			sprite.play("boss_enemy_bottom")

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		GameManager.reduce_life(1)
		queue_free()

func update_health_bar():
	if current_health > 0 and current_health <= bar_sprites.size():
		health_bar.texture = bar_sprites[current_health - 1]
	else:
		health_bar.visible = false

func take_damage(amount := 1):
	current_health -= amount
	update_health_bar()
	# GameManager.play_sfx("click_boss")
	
	if current_health <= 0:
		GameManager.play_sfx("click_boss")
		emit_signal("boss_died")
		GameManager.add_points(100)
		queue_free()
