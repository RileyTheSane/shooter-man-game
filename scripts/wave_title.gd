extends Control



func _on_temp_timeout() -> void:
	$AnimationPlayer.play("Main")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Main":
		$PauseTime.start()
		

func _on_pause_time_timeout() -> void:
	$AnimationPlayer.play("Hide")

func update_wave_num(num):
	$Label.text = "Wave " + str(num)
