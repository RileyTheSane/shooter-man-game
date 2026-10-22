extends CanvasLayer

func _on_play_pressed() -> void:
	$"..".startCutscene()
	$Click.play()


func _on_stardance_button_pressed() -> void:
	OS.shell_open("https://stardance.hackclub.com/projects/21411")
	$Click.play()

var difficulty = "easy"

func _ready(): # set the easy butto to be clicked by default
	$Control/EasyButton.scale = Vector2(1, 1)
	$Control/MediumButton.scale = Vector2(.8, .8)
	$Control/HardButton.scale = Vector2(.8, .8)
	
	$Control/EasyButton.modulate = Color(1, 1, 1, 1)
	$Control/MediumButton.modulate = Color(1, 1, 1, .7)
	$Control/HardButton.modulate = Color(1, 1, 1, .7)

func _on_easy_button_pressed() -> void:
	difficulty = "easy"
	$Click.play()
	$"..".change_difficulty(difficulty)
	
	$Control/EasyButton.scale = Vector2(1, 1)
	$Control/MediumButton.scale = Vector2(.8, .8)
	$Control/HardButton.scale = Vector2(.8, .8)
	
	$Control/EasyButton.modulate = Color(1, 1, 1, 1)
	$Control/MediumButton.modulate = Color(1, 1, 1, .7)
	$Control/HardButton.modulate = Color(1, 1, 1, .7)

func _on_medium_button_pressed() -> void:
	difficulty = "medium"
	$Click.play()
	$"..".change_difficulty(difficulty)
	
	$Control/EasyButton.scale = Vector2(.8, .8)
	$Control/MediumButton.scale = Vector2(1, 1)
	$Control/HardButton.scale = Vector2(.8, .8)
	
	$Control/EasyButton.modulate = Color(1, 1, 1, .7)
	$Control/MediumButton.modulate = Color(1, 1, 1, 1)
	$Control/HardButton.modulate = Color(1, 1, 1, .7)

func _on_hard_button_pressed() -> void:
	difficulty = "hard"
	$Click.play()
	$"..".change_difficulty(difficulty)
	
	$Control/EasyButton.scale = Vector2(.8, .8)
	$Control/MediumButton.scale = Vector2(.8, .8)
	$Control/HardButton.scale = Vector2(1, 1)
	
	$Control/EasyButton.modulate = Color(1, 1, 1, .7)
	$Control/MediumButton.modulate = Color(1, 1, 1, .7)
	$Control/HardButton.modulate = Color(1, 1, 1, 1)

func getDifficulty():
	return difficulty
