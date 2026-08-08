extends CanvasLayer


func _on_retry_button_pressed() -> void:
	$"..".reset_game()
	$RetryButton/AnimationPlayer.play("exit")
