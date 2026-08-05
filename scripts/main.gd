extends Node2D

func start_game():
	$WavePlayer.start()

func _on_timer_timeout() -> void:
	start_game()
	
func reset_game():
	var transparencyTween = create_tween() # make a tween that covers the screen with white
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 1), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
