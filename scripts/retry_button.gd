extends Button

func _ready(): # hide the button so it can't be seen outside of the frame
	visible = false

func show_button(): # play the animation to enter the button into the scene
	visible = true
	$AnimationPlayer.play("enter")


func _on_animation_player_animation_finished(anim_name: StringName) -> void: # reset button to off screen
	if anim_name == "exit":
		visible = false
		$AnimationPlayer.play("RESET")
