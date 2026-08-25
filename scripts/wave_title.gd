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
	match num:
		1:
			$NumberWiggle.play("Wiggle1")
		2:
			$NumberWiggle.play("Wiggle2")
		3:
			$NumberWiggle.play("Wiggle3")
		4:
			$NumberWiggle.play("Wiggle4")
		5:
			$NumberWiggle.play("Wiggle5")
		6:
			$NumberWiggle.play("Wiggle6")
		7:
			$NumberWiggle.play("Wiggle7")
		8:
			$NumberWiggle.play("Wiggle8")
		9:
			$NumberWiggle.play("Wiggle9")
