extends Area2D

@onready var animated_sprites = $AnimatedSprite2D

func _ready():
	GameManager.connect("lives_changed", self._update_animation)
	position = get_viewport_rect().size / 2
		
func _update_animation(lives):
	# print('updating.. ', lives)
	match lives:
		3:
			animated_sprites.play("idle")
		2:
			animated_sprites.play("hurt1")
		1:
			animated_sprites.play("hurt2")
		0:
			animated_sprites.play("dead")
