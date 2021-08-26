extends "res://Scenes/Scripts/PawnMovement.gd"

class_name Player

var g_player_score = 0
var g_action_debouncer = false
var g_level_time = 0
var obj_score_overlap = null

func _on_ScoreTimer_timeout():
	print("scoretimer_timeout")
	g_player_score += 30
	$HUD/Score.text = str(g_player_score)
	obj_score_overlap.consume(Color("6ef70c0c"))
	$ScoreSound.play()

func enter_score_area(object):
	obj_score_overlap = object
	$ScoreTimer.start()
	print("enter_score_area")
	
func exit_score_area():
	print("exit_score_area")
	$ScoreTimer.stop()

func _ready():
	$HUD/Score.text = str(g_player_score)
	$HUD/Time.text = str("Time Left: ", g_level_time)
	$LevelTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_LevelTimer_timeout():
	g_level_time += 1
	$HUD/Time.text = str("Time Left: ", g_level_time)
	# End Game
