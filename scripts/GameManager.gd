extends Node

signal game_over
signal lives_changed
signal score_changed

var lives := 3
var score := 0

func reduce_life():
	print(".... REDUCING LIFE")
	lives -= 1
	emit_signal("lives_changed", lives)
	
	if lives <= 0:
		emit_signal("game_over")
		
func add_score(points: int):
	score += points
	emit_signal("score_changed", score)
