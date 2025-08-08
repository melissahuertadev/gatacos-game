extends Area2D

@export var max_lives := 3
var current_lives := 3

@onready var animated_sprites = $AnimatedSprite2D

signal player_hit(lives_left)

func _ready():
	current_lives = max_lives
	update_animation()
	position = get_viewport_rect().size / 2

func take_damage():
	if current_lives <= 0:
		return
	
	current_lives -=1
	update_animation()
	emit_signal("player_hit", current_lives)
	GameManager.reduce_life()
		
func update_animation():
	match current_lives:
		3:
			animated_sprites.play("idle")
		2:
			animated_sprites.play("hurt1")
		1:
			animated_sprites.play("hurt2")
		0:
			animated_sprites.play("dead")
