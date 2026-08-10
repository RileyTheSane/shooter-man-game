extends Control

func update(max_health, cur_health):
	var percentage = cur_health / max_health
	$Bar.size = Vector2(25 * percentage, 3)
	
	if percentage == 1:
		hide()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage > .5:
		show()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage <= .5 && percentage > .25:
		show()
		$Bar.color = Color(1, .647, 0, 1)
	elif percentage <= .25:
		show()
		$Bar.color = Color(1, 0, 0, 1)
