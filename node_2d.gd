extends Node2D
var paused: bool = false
var Ipaused: bool = true



func _on_pause_button_button_up() -> void:
	if Ipaused:
		if paused == false:
			paused = true
			get_tree().paused = paused

		else:
			paused = false
			get_tree().paused = paused
