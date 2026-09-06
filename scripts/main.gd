extends Node2D

func _ready():
	$MainMenu.show()
	$ShooterMan.mainMenuState()
	start_game()

func start_game():
	#$WavePlayer.start()
	pass

	
func reset_game():
	var transparencyTween = create_tween() # make a tween that covers the screen with white
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 1), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
	
	$ResetTimer.start() # clear all of the gloinks, projs, and effects, move camera back to normal pos, remove monochrome filter, make white rect transparent again

func startCutscene():
	var transparencyTween = create_tween() # make a tween that covers the screen with white
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 1), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
	
	var mainMenuTween = create_tween() # hide the main menu buttons and title
	mainMenuTween.tween_property($MainMenu/Control, "modulate", Color(1, 1, 1, 0), 1.25)\
		.set_trans(Tween.TRANS_LINEAR)
	
	$CutsceneTimer.start()

func _on_reset_timer_timeout() -> void:
	# clear all gloinks, projectiles, and particles
	var gloinks = %Gloinks.get_children()
	for gloink in gloinks:
		gloink.queue_free()
	
	var projectiles = %Projectiles.get_children()
	for proj in projectiles:
		proj.queue_free()
	
	var effects = %Effects.get_children()
	for effect in effects:
		effect.queue_free()
	
	$Camera2D.position = Vector2(480, 270) # return camera back to normal
	$Camera2D.zoom = Vector2(1, 1)
	
	var transparencyTween = create_tween() # make everything visible again
	transparencyTween.tween_property($TransitionCover, "color", Color(1, 1, 1, 0), .6333)\
		.set_trans(Tween.TRANS_LINEAR)
	
	%ShooterMan.reset() # reset bob
	$WavePlayer.reset() # reset the wave num
	
	$MonochromeFilter/ColorRect.color = Color(1, 1, 1, 0) # remove grayscale


func _on_cutscene_timer_timeout() -> void:
	$MainMenu.hide()
	$ShooterMan.nonexistentState()
