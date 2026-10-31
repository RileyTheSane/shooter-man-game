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
var wave_num = 9

func start():
	wave9()
	%ShooterMan.can_take_damage = false # make him invincible until the wave actually starts
	$PreventNewWave.start()

func _physics_process(_delta: float) -> void:
	if %Gloinks.get_child_count() == 0 && new_wave_can_start:
		if !pause_has_happened && $BetweenWaveDelay.is_stopped(): # add a pause between the end of a wave and the star of a new one
			$BetweenWaveDelay.start()
		elif pause_has_happened:
			wave_num += 1
			match wave_num:
				1:
					wave1()
				2:
					wave2()
				3:
					wave3()
				4:
					wave4()
				5:
					wave5()
				6:
					wave6()
				7:
					wave7()
				8:
					wave8()
				9:
					wave9()
				10:
					$"..".endGame()
			$PreventNewWave.start()
			new_wave_can_start = false
			pause_has_happened = false

func wave1():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(1)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([triangle], [7], 1, 11)
		"medium":
			make_set_of_gloinks([triangle], [8], 1, 8.5)
		"hard":
			make_set_of_gloinks([triangle], [10], 1, 6)
		
func wave2():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(2)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([triangle, square], [5, 2], 1, 11)
		"medium":
			make_set_of_gloinks([triangle, square], [7, 2], 1, 8.5)
		"hard":
			make_set_of_gloinks([triangle, square], [10, 3], 1, 6)

func wave3():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(3)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([triangle, square, pentagon], [3, 2, 3], 1, 12)
		"medium":
			make_set_of_gloinks([triangle, square, pentagon], [4, 3, 3], 1, 8.5)
		"hard":
			make_set_of_gloinks([triangle, square, pentagon], [5, 4, 3], 1, 7)

func wave4():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(4)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([triangle, square, pentagon], [3, 3, 4], 1, 12)
		"medium":
			make_set_of_gloinks([triangle, square, pentagon], [5, 4, 4], 1, 9)
		"hard":
			make_set_of_gloinks([triangle, square, pentagon], [7, 5, 5], 1, 7)

func wave5():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(5)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([square, pentagon, hexagon], [4, 4, 3], 1, 14)
		"medium":
			make_set_of_gloinks([square, pentagon, hexagon], [4, 4, 3], 1, 11)
		"hard":
			make_set_of_gloinks([square, pentagon, hexagon], [4, 4, 3], 1, 9)

func wave6():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(6)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([pentagon, hexagon], [5, 4], 1, 12)
		"medium":
			make_set_of_gloinks([pentagon, hexagon], [6, 4], 1, 10)
		"hard":
			make_set_of_gloinks([pentagon, hexagon], [8, 5], 1, 9)

func wave7():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(7)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([pentagon, hexagon, heptagon], [3, 2, 3], 1, 13)
		"medium":
			make_set_of_gloinks([pentagon, hexagon, heptagon], [4, 2, 3], 1, 12)
		"hard":
			make_set_of_gloinks([pentagon, hexagon, heptagon], [6, 2, 3], 1, 9)

func wave8():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(8)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([hexagon, heptagon, octagon], [2, 2, 3], 1, 15)
		"medium":
			make_set_of_gloinks([hexagon, heptagon, octagon], [3, 3, 4], 1, 12)
		"hard":
			make_set_of_gloinks([hexagon, heptagon, octagon], [4, 4, 4], 1, 9)
	
func wave9():
	var difficulty = $"..".get_difficulty()
	$WaveTitle.update_wave_num(9)
	$WaveTitle.play()
	
	match difficulty:
		"easy":
			make_set_of_gloinks([triangle, square, pentagon, hexagon, heptagon, octagon], [3, 3, 3, 2, 3, 3], 1, 16)
		"medium":
			make_set_of_gloinks([triangle, square, pentagon, hexagon, heptagon, octagon], [3, 3, 3, 2, 4, 3], 1, 13)
		"hard":
			make_set_of_gloinks([triangle, square, pentagon, hexagon, heptagon, octagon], [3, 3, 4, 3, 4, 4], 1, 9)
	
	


func make_new_gloink(shape: Object) -> Object: # creates a new gloink object at a random spot around the screen
	var new_gloink = shape.instantiate()
	new_gloink.global_position = random_path_point()
	new_gloink.shooter_man = $"../ShooterMan"
	return new_gloink

func make_new_gloinks(shape: Object, num: int, low: int, high: float): # creates a certain  number of a gloink and places that gloink somwewhere around the screen with a random start wait time
	for i in num:
		var new_gloink = make_new_gloink(shape)
		new_gloink.get_node("StartWait").wait_time = randf_range(low, high)
		%Gloinks.add_child(new_gloink)

func make_set_of_gloinks(shapes: Array, amounts: Array, low: int, high: float):
	for i in range(shapes.size()):
		make_new_gloinks(shapes[i], amounts[i], low, high)

func random_path_point() -> Vector2: # gets a random point from around the screen
	path.progress_ratio = randf()
	return path.global_position

func _on_delay_timeout() -> void:
	new_wave_can_start = true

func _on_between_wave_delay_timeout() -> void:
	pause_has_happened = true


func stop_wave():
	var gloinks = %Gloinks.get_children() # get all gloinks to loop through and disable
	for gloink in gloinks:
		gloink.get_node("StartWait").paused = true # make sure they can't start moving after they've been disabled
		if gloink.has_node("ShootTimer"): # make sure they can't shoot after they've been disabled
			gloink.get_node("ShootTimer").paused = true
		
		if gloink.has_node("RollTimer"): # make sure the squares can't roll after beign disabled
			gloink.get_node("RollTimer").paused = true
		
		if gloink.has_node("LaunchAnimPause"):
			gloink.get_node("LaunchAnimPause").paused = true
			gloink.get_node("AttackStartDelay").paused = true
			gloink.get_node("AnimationPlayer").pause()
		
		if gloink.has_node("MaxLifetime"): # stop hexagons from decaying
			gloink.get_node("MaxLifetime").paused = true
		gloink.enabled = false
		
	var effects = %Effects.get_children() # get all effects to pause from playing
	for effect in effects:
		if effect.has_node("AnimationPlayer"):
			effect.get_node("AnimationPlayer").pause()
	
	var projectiles = %Projectiles.get_children() # stop all projectiles from moving and decaying
	for proj in projectiles:
		if proj.has_node("Decay"):
			proj.get_node("Decay").paused = true
		proj.enabled = false 

func reset(): # set the wave back to the first one
	wave_num = 0
