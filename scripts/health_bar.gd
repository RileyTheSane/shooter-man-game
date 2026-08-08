extends Control


func update(max_health, cur_health):
	var percentage = cur_health / max_health
	$Bar.size = Vector2(40 * percentage, 4)
	
	if percentage == 1:
		hide_bar()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage > .5:
		show_bar()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage <= .5 && percentage > .25:
		show_bar()
		$Bar.color = Color(1, .647, 0, 1)
	elif percentage <= .25:
		show_bar()
		$Bar.color = Color(1, 0, 0, 1)

func hide_bar():
	$Outline.visible = false
	$Background.visible = false
	$Bar.visible = false

func show_bar():
	$Outline.visible = false
	$Background.visible = false
	$Bar.visible = false
