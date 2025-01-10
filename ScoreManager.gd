extends Node

var current_score: int = 0
var high_score: int = 0
var global_score: int = 0
var grit: int = 0
var score_grit_used: int =0
var high_score_grit_used: int =0
var global_score_grit_used: int =0
var nogritscore: int = 0
var nogrithighscore: int = 0
var nogritglobalscore: int = 0
# Save the high score and global score to a file
func save_scores():
	var save_data = {
		"high_score": high_score,
		"global_score": global_score,
		"grit": grit,
		"high_score_grit_used": high_score_grit_used,
		"global_score_grit_used": global_score_grit_used,
		"nogrithighscore": nogrithighscore,
		"nogritglobalscore": nogritglobalscore
	}
	var save_path = "user://scores.save"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:  # Ensure the file was successfully opened
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Scores saved successfully.")
	else:
		print("Failed to open file for writing: " + save_path)

# Load the high score and global score from a file
func load_scores():
	var save_path = "user://scores.save"
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:  # Ensure the file was successfully opened
			var save_text = file.get_as_text()
			file.close()  # Close the file immediately after reading
			
			# Parse the JSON data
			var save_data = JSON.parse_string(save_text)
			if typeof(save_data) == TYPE_DICTIONARY:  # Check if parsing was successful
				high_score = save_data.get("high_score", 0)
				global_score = save_data.get("global_score", 0)
				grit = save_data.get("grit", 0)
				high_score_grit_used = save_data.get("high_score_grit_used", 0)
				global_score_grit_used = save_data.get("global_score_grit_used", 0)
				nogrithighscore = save_data.get("nogrithighscore", 0)
				nogritglobalscore = save_data.get("nogritglobalscore", 0)
				print("Scores loaded successfully.")
			else:
				print("Failed to parse JSON data: " + save_text)
		else:
			print("Failed to open file for reading: " + save_path)
	else:
		print("Save file does not exist: " + save_path)
