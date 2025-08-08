extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var direction_from := "left" # Puede ser: "left", "right", "top", "bottom"
@export var health: int = 5
@export var speed: float = 80.0
@export var direction: Vector2 = Vector2.ZERO

var target: Node2D = null

func _ready():
	# print("🟣 sprite es:", sprite)
	set_process(true)

func _process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
#	else:
#		print("❌ target es null")
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		health -= 1
		if health <= 0:
			GameManager.add_points(100)
			queue_free()

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
			sprite.play("boss_enemiyright")
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
