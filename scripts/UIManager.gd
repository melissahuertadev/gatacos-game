extends CanvasLayer

@onready var hearts = [$HP/Heart1, $HP/Heart2, $HP/Heart3]
@export var full_heart_texture: Texture2D
@export var empty_heart_texture: Texture2D

func _ready():
	print(">> UI ready ")
	GameManager.connect("lives_changed", self._on_lives_changed)
	_on_lives_changed(GameManager.lives) # Llama manualmente a la función _on_lives_changed() una sola vez al iniciar.
	
func _on_lives_changed(current_lives):
	for i in hearts.size():
		if i < current_lives:
			hearts[i].texture = full_heart_texture
		else :
			hearts[i].texture = empty_heart_texture
	print(">> _on_lives_changed")
