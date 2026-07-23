extends Node2D

@onready var path = $Path2D/PathFollow2D
const triangle = preload("res://scenes/triangle_gloink.tscn")
const square = preload("res://scenes/square_gloink.tscn")
const pentagon = preload("res://scenes/pentagon_gloink.tscn")
const hexagon = preload("res://scenes/hexagon_gloink.tscn")
const heptagon = preload("res://scenes/heptagon_gloink.tscn")
const octagon = preload("res://scenes/octagon_gloink.tscn")
var new_wave_can_start = false
var pause_has_happened = false
var wave_num = 1

func start():
	wave1()
	$PreventNewWave.start()

func _physics_process(_delta: float) -> void:
	if %Gloinks.get_child_count() == 0 && new_wave_can_start:
		if !pause_has_happened && $BetweenWaveDelay.is_stopped(): # add a pause between the end of a wave and the star of a new one
			$BetweenWaveDelay.start()
		elif pause_has_happened:
			wave_num += 1
			match wave_num:
				2:
					wave2()
					$PreventNewWave.start()
				3:
					wave3()
					$PreventNewWave.start()
				4:
					wave4()
					$PreventNewWave.start()
				5:
					wave5()
					$PreventNewWave.start()
				6:
					wave6()
					$PreventNewWave.start()
				7:
					wave7()
					$PreventNewWave.start()
				8:
					wave8()
					$PreventNewWave.start()
				9:
					wave9()
					$PreventNewWave.start()
			new_wave_can_start = false
			pause_has_happened = false

func wave1():
	$WaveTitle.update_wave_num(1)
	$WaveTitle.play()
	
	for i in 10:
		var new_gloink = make_new_gloink(triangle)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
		
func wave2():
	$WaveTitle.update_wave_num(2)
	$WaveTitle.play()
	
	for i in 10:
		var new_gloink = make_new_gloink(triangle)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 3:
		var new_gloink = make_new_gloink(square)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)

func wave3():
	$WaveTitle.update_wave_num(3)
	$WaveTitle.play()
	
	for i in 5:
		var new_gloink = make_new_gloink(triangle)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = make_new_gloink(square)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 3:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(2, 7)
		%Gloinks.add_child(new_gloink)

func wave4():
	$WaveTitle.update_wave_num(4)
	$WaveTitle.play()
	
	for i in 7:
		var new_gloink = make_new_gloink(triangle)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 5:
		var new_gloink = make_new_gloink(square)
		new_gloink.get_node("StartWait").wait_time = randf_range(2, 7)
		%Gloinks.add_child(new_gloink)
	
	for i in 5:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
		
func wave5():
	$WaveTitle.update_wave_num(5)
	$WaveTitle.play()
	
	for i in 4:
		var new_gloink = make_new_gloink(square)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
		
	for i in 3:
		var new_gloink = make_new_gloink(hexagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)

func wave6():
	$WaveTitle.update_wave_num(6)
	$WaveTitle.play()
	
	for i in 8:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(2, 7)
		%Gloinks.add_child(new_gloink)
	
	for i in 5:
		var new_gloink = make_new_gloink(hexagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
		
func wave7():
	$WaveTitle.update_wave_num(7)
	$WaveTitle.play()
	
	for i in 6:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(2, 7)
		%Gloinks.add_child(new_gloink)
	
	for i in 2:
		var new_gloink = make_new_gloink(hexagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
		
	for i in 3:
		var new_gloink = make_new_gloink(heptagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
		
func wave8():
	$WaveTitle.update_wave_num(8)
	$WaveTitle.play()
	
	for i in 4:
		var new_gloink = make_new_gloink(hexagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = make_new_gloink(heptagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
		
	for i in 4:
		var new_gloink = make_new_gloink(octagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
		
func wave9():
	$WaveTitle.update_wave_num(9)
	$WaveTitle.play()
	
	for i in 3:
		var new_gloink = make_new_gloink(triangle)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 3:
		var new_gloink = make_new_gloink(square)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = make_new_gloink(pentagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(2, 7)
		%Gloinks.add_child(new_gloink)
		
	for i in 3:
		var new_gloink = make_new_gloink(hexagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = make_new_gloink(heptagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(3, 9)
		%Gloinks.add_child(new_gloink)
		
	for i in 4:
		var new_gloink = make_new_gloink(octagon)
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)

func make_new_gloink(shape: Object) -> Object: # creates a new gloink object at a random spot around the screen
	var new_gloink = shape.instantiate()
	new_gloink.global_position = random_path_point()
	new_gloink.shooter_man = $"../ShooterMan"
	return new_gloink

func random_path_point() -> Vector2: # gets a random point from around the screen
	path.progress_ratio = randf()
	return path.global_position

func _on_delay_timeout() -> void:
	new_wave_can_start = true


func _on_between_wave_delay_timeout() -> void:
	pause_has_happened = true
