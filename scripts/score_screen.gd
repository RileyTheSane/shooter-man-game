extends CanvasLayer

func _on_retry_button_pressed() -> void:
	print(1)
	$"..".reset_game()
	$RetryButton/AnimationPlayer.play("exit")
	$AnimationPlayer.play("hide")
	$Click.play()

func start():
	$Digits.setValue($"..".gloinkKillPoints)
	$Digits2.setValue(-$"..".damageTaken)
	$Digits3.setValue(-((Time.get_ticks_msec() - $"..".roundStarted) / 800))
	$Digits4.setValue(-($"..".bulletsUsed / 2))
	$Digits5.setValue($"..".gloinkKillPoints - $"..".damageTaken - ((Time.get_ticks_msec() - $"..".roundStarted) / 800) - ($"..".bulletsUsed / 2))
	$AnimationPlayer.play("show")
