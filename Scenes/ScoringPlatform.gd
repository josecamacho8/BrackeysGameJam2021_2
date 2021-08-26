extends Area2D

var consumed = false

func change_color(color):
	$Polygon2D.color = color

func consume(color):
	consumed = true
	change_color(color)
	
func _on_ScoringPlatform_body_entered(body):
	if body is Player and consumed == false:
		body.enter_score_area(self)

func _on_ScoringPlatform_body_exited(body):
	if body is Player:
		body.exit_score_area()
