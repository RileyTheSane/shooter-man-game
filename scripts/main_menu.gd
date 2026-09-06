extends CanvasLayer

func _on_play_pressed() -> void:
	$"..".startCutscene()


func _on_stardance_button_pressed() -> void:
	OS.shell_open("https://stardance.hackclub.com/projects/21411")
