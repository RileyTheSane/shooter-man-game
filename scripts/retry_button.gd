extends Button

func _ready(): # hide the button so it can't be seen outside of the frame
	visible = false

func show_button(): # play the animation to enter the button into the scene
	print(1)
	visible = true
	$AnimationPlayer.play("enter")
