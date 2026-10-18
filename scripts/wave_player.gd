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
					$PreventNewWave.start()
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
	
	make_new_gloinks(triangle, 10, 1, 6)
		
func wave2():
	$WaveTitle.update_wave_num(2)
	$WaveTitle.play()
	
	make_new_gloinks(triangle, 10, 1, 6)
	make_new_gloinks(square, 3, 1, 6)

func wave3():
	$WaveTitle.update_wave_num(3)
	$WaveTitle.play()
	
	make_new_gloinks(triangle, 5, 1, 6)
	make_new_gloinks(square, 4, 1, 6)
	make_new_gloinks(pentagon, 3, 2, 7)

func wave4():
	$WaveTitle.update_wave_num(4)
	$WaveTitle.play()
	
	make_new_gloinks(triangle, 7, 1, 6)
	make_new_gloinks(square, 5, 1, 6)
	make_new_gloinks(pentagon, 5, 2, 7)
		
func wave5():
	$WaveTitle.update_wave_num(5)
	$WaveTitle.play()
	
	make_new_gloinks(square, 4, 1, 6)
	make_new_gloinks(pentagon, 4, 2, 7)
	make_new_gloinks(hexagon, 3, 3, 9)

func wave6():
	$WaveTitle.update_wave_num(6)
	$WaveTitle.play()
	
	make_new_gloinks(pentagon, 8, 2, 7)
	make_new_gloinks(hexagon, 5, 3, 9)
		
func wave7():
	$WaveTitle.update_wave_num(7)
	$WaveTitle.play()
	
	make_new_gloinks(pentagon, 6, 2, 7)
	make_new_gloinks(hexagon, 2, 3, 9)
	make_new_gloinks(heptagon, 3, 3, 9)
		
func wave8():
	$WaveTitle.update_wave_num(8)
	$WaveTitle.play()
	
	make_new_gloinks(hexagon, 4, 3, 9)
	make_new_gloinks(heptagon, 4, 3, 9)
	make_new_gloinks(octagon, 4, 1, 6)
		
func wave9():
	$WaveTitle.update_wave_num(9)
	$WaveTitle.play()
	
	make_new_gloinks(triangle, 3, 1, 6)
	make_new_gloinks(square, 3, 1, 6)
	make_new_gloinks(pentagon, 4, 2, 7)
	make_new_gloinks(hexagon, 3, 3, 9)
	make_new_gloinks(heptagon, 4, 3, 9)
	make_new_gloinks(octagon, 4, 1, 6)

func make_new_gloink(shape: Object) -> Object: # creates a new gloink object at a random spot around the screen
	var new_gloink = shape.instantiate()
	new_gloink.global_position = random_path_point()
	new_gloink.shooter_man = $"../ShooterMan"
	return new_gloink

func make_new_gloinks(shape: Object, num: int, low: int, high: int): # creates a certain  number of a gloink and places that gloink somwewhere around the screen with a random start wait time
	for i in num:
		var new_gloink = make_new_gloink(shape)
		new_gloink.get_node("StartWait").wait_time = randf_range(low, high)
		%Gloinks.add_child(new_gloink)

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
