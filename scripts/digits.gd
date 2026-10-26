extends Control
const DIGIT = preload("res://scenes/digit.tscn")

func setValue(num: int):
	var number = str(num)
	
	for child in get_children():
		child.queue_free()
	
	for i in range(number.length()):
		var new_digit = DIGIT.instantiate()
		new_digit.position = Vector2(i * 30, -14)
		new_digit.setDigit(number[i])
		add_child(new_digit)
