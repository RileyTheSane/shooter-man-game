extends Control
var tween

func update(max_health, cur_health, small_bar):
	var percentage = cur_health / max_health
	$Bar.size = Vector2(40 * percentage, 4)
	
	if percentage == 1:
		if small_bar: # if it's updating the small bar, just straight hide or show, if it's updating big bar, slow hide or show so it looks nicer
			hide()
		else:
			slow_hide()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage > .5:
		if small_bar:
			show()
		else:
			slow_show()
		$Bar.color = Color(0, 1, 0, 1)
	elif percentage <= .5 && percentage > .25:
		if small_bar:
			show()
		else:
			slow_show()
		$Bar.color = Color(1, .647, 0, 1)
	elif percentage <= .25:
		if small_bar:
			show()
		else:
			slow_show()
		$Bar.color = Color(1, 0, 0, 1)

func slow_show(): # slowly fade in the health bar
	if tween: # make sure another tween isn't running
		tween.kill()
		tween = create_tween()
	elif tween == null:
		tween = create_tween()
				
	tween.tween_property(self, "modulate:a", 1, .75)\
		.set_trans(Tween.TRANS_LINEAR)

func slow_hide(): # slowly fade out the health bar
	if tween: # make sure another tween isn't running
		tween.kill()
		tween = create_tween()
	elif tween == null:
		tween = create_tween()
				
	tween.tween_property(self, "modulate:a", 0, .75)\
		.set_trans(Tween.TRANS_LINEAR)

func quick_hide(): # quicky hide it on game start
	self.modulate = Color(1, 1, 1, 0)
