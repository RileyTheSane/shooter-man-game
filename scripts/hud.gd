extends CanvasLayer
var shooter_man
var tween
var tween_init = false

func _on_retry_button_pressed() -> void:
	$"..".reset_game()
	$RetryButton/AnimationPlayer.play("exit")
	$Click.play()

func _ready():
	shooter_man = %ShooterMan

# a function that handles the animations for the ticking of the vingette
func vingette(action):
	if !tween_init: # can't init tween in _read() bc it causes error for some reason so it happens here
		tween_init = true
		tween = create_tween()
	
	match action:
		# tweens the showing of the vingette over 1.25 seconds and starts the wait before damaging the player
		"show":
			# make sure another tween isn't running
			tween.kill()
			tween = create_tween()
			
			tween.tween_property($Vingette, "modulate:a", 1, .75)\
				.set_trans(Tween.TRANS_LINEAR)
				
			$Vingette/PulseWait.start()
			$HealthBar.slow_show() # bring in the big health bar
		"hide":
			# pause the pulse anim and stop timers so the damage tick stops
			$Vingette/AnimationPlayer.pause() # pause pulse
			$Vingette/PulseWait.stop() # stops the pulse animation from getting started
			
			# make sure the the show tween isn't running
			tween.kill()
			tween = create_tween()
			
			# hide tween
			tween.tween_property($Vingette, "modulate:a", 0, .75)\
				.set_trans(Tween.TRANS_LINEAR)
			
			$HealthBar.slow_hide() # bring in the big health bar
	

# give the player grace so they don't start taking damage after immdeiately stepping outside of the screen
func _on_pulse_wait_timeout() -> void:
	$Vingette/AnimationPlayer.seek(0)
	$Vingette/AnimationPlayer.play("pulse")

func do_storm_tick():
	shooter_man.do_storm_tick()
