extends Control

func _ready():
	ScoreManager.current_score = 0

func _process(delta: float):
	$Score.text = "%d" % ScoreManager.current_score
#Score: 

func _on_timer_timeout() -> void:
	ScoreManager.current_score += 1


func _on_pay_grit_button_up() -> void:
	$Buttonaudio.play()


func _on_choose_death_button_up() -> void:
	$Buttonaudio.play()


func _on_pause_button_button_down() -> void:
	$"Buttonaudio".play()
