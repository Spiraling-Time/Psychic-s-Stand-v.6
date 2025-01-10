extends Node2D



@onready var ani = $AnimationPlayer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	ani.play("Normal")
	#ScoreManager.high_score = 0
	#ScoreManager.high_score_grit_used = 0
	#ScoreManager.nogrithighscore = 0
	#ScoreManager.global_score = 0
	#ScoreManager.global_score_grit_used = 0
	#ScoreManager.nogritglobalscore = 0
	#ScoreManager.save_scores()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spikem_body_entered(body: Node2D) -> void:
	ani.play("Spike")
	if body.has_method("take_damage") and body != self:
		var randknockback = randi_range(200,400)
		body.take_damage("Melee", 30, false, true, false, false, randknockback)


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
