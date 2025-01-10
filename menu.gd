extends Control

var ending: bool = false
var scoretype: bool = false


func _ready():
	$Score.text = "Score: %d" % ScoreManager.current_score
	$"Score Grit Used".text = "Grit Used: %d" % ScoreManager.score_grit_used
	# Reset current score for the next game
	# Load scores at the start of the game
	ScoreManager.load_scores()
	
	
	$Highscore.text = "High Score: %d" % ScoreManager.high_score
	$GlobalScore.text = "Global Score: %d" % ScoreManager.global_score
	$"Highscore Grit Used".text = "Grit Used: %d" % ScoreManager.high_score_grit_used
	$"GlobalScore Grit Used".text = "Grit Used: %d" % ScoreManager.global_score_grit_used
	$Grit.text = "Grit: %d" % ScoreManager.grit


func _on_play_pressed() -> void:
	ScoreManager.current_score = 0
	ScoreManager.nogritscore = 0
	$Audio.play()
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_quit_pressed() -> void:
	ending = true
	$Audio.play()

func _on_audio_finished() -> void:
	if ending: get_tree().quit()


func _on_swapscores_pressed() -> void:
	$Audio.play()
	if scoretype:
		$Score.text = "Score: %d" % ScoreManager.current_score
		$"Score Grit Used".visible = true
		$"Score Grit Used".text = "Grit Used: %d" % ScoreManager.score_grit_used
		$Highscore.text = "High Score: %d" % ScoreManager.high_score
		$GlobalScore.text = "Global Score: %d" % ScoreManager.global_score
		$"Highscore Grit Used".visible = true
		$"Highscore Grit Used".text = "Grit Used: %d" % ScoreManager.high_score_grit_used
		$"GlobalScore Grit Used".visible = true
		$"GlobalScore Grit Used".text = "Grit Used: %d" % ScoreManager.global_score_grit_used
		$Grit.text = "Grit: %d" % ScoreManager.grit
		scoretype = false
	else:
		$Score.text = "Score: %d" % ScoreManager.nogritscore
		$"Score Grit Used".visible = false
		$Highscore.text = "High Score: %d" % ScoreManager.nogrithighscore
		$GlobalScore.text = "Global Score: %d" % ScoreManager.nogritglobalscore
		$"Highscore Grit Used".visible = false
		$"GlobalScore Grit Used".visible = false
		$Grit.text = "Scores Before
		Any Grit Used"
		scoretype = true
