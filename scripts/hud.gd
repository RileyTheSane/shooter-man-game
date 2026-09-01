extends CanvasLayer
var shooter_man
var tween

func _on_retry_button_pressed() -> void:
	$"..".reset_game()
	$RetryButton/AnimationPlayer.play("exit")

func _ready():
	shooter_man = %ShooterMan

# a function that handles the animations for the ticking of the vingette
func vingette(action):
	match action:
		# tweens the showing of the vingette over .75 seconds and starts the wait before damaging the player
		"show":
			if tween: # make sure another tween isn't running
				tween.kill()
				tween = create_tween()
			elif tween == null:
				tween = create_tween()
			
			tween.tween_property($Vingette, "modulate:a", .75, .75)\
				.set_trans(Tween.TRANS_LINEAR)
				
			$Vingette/PulseWait.start()
			
			$HealthBar.slow_show() # bring in the big health bar
		"hide":
			# pause the pulse anim and stop timers so the damage tick stops
			$Vingette/AnimationPlayer.pause() # pause pulse
			$Vingette/PulseWait.stop() # stops the pulse animation from getting started
			
			if tween: # make sure the the show tween isn't running
				tween.kill()
				print(3)
				tween = create_tween()
			elif tween == null:
				tween = create_tween()
			
			
			# hide tween
			tween.tween_property($Vingette, "modulate:a", 0, .75)\
				.set_trans(Tween.TRANS_LINEAR)
			
			$HealthBar.slow_hide() # bring in the big health bar
	

# give the player grace so they don't start taking damage after immdeiately stepping outside of the screen
func _on_pulse_wait_timeout() -> void:
	$Vingette/AnimationPlayer.play("pulse")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pulse":
		$Vingette/AnimationPlayer.play("pulse")
		shooter_man.do_storm_tick()
