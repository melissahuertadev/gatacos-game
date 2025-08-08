extends Node2D

@onready var enemy_scene = preload("res://scenes/Enemy.tscn")

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(0, randf_range(0, get_viewport_rect().size.y))
	add_child(enemy)
	print("Enemy created")
