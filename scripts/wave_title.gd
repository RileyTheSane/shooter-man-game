extends Control

func play():
	visible = true
	$AnimationPlayer.play("Main")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Main":
		$PauseTime.start() # pause before playing the hide animation
	if anim_name == "Hide":
		visible = false
		$"../../ShooterMan".can_take_damage = true # allow bob to take damage

func _on_pause_time_timeout() -> void:
	$AnimationPlayer.play("Hide")

func update_wave_num(num):
	$Label.text = "Wave " + str(num)
