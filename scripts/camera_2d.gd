extends Camera2D

func play_death_camera_effects():
	$ZoomPause.start() # start the timer to wait before zooming into the player
	
	var greyscaleTween = create_tween() # make a tween that moves to the player
	greyscaleTween.tween_property($"../MonochromeFilter/ColorRect", "color", Color(1, 1, 1, 1), 1.75)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	


func _on_zoom_pause_timeout() -> void:
	var playerPos = %ShooterMan.position
	
	var posTween = create_tween() # make a tween that moves to the player
	posTween.tween_property(self, "position", playerPos, 1.25)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
		
	var zoomTween = create_tween() # make a tween that zooms into the player
	zoomTween.tween_property(self, "zoom", Vector2(2.5, 2.5), 1.25)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
		
	
	
