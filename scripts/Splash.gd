extends Control

func _ready():
	$SplashTimer.start()

func _on_splash_timer_timeout() -> void:
	print(" time out")
	get_tree().change_scene_to_file("res://scenes/main/Main.tscn")
