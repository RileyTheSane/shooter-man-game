extends Node2D

@onready var path = $Path2D/PathFollow2D
const triangle = preload("res://scenes/triangle_gloink.tscn")
const square = preload("res://scenes/square_gloink.tscn")
const pentagon = preload("res://scenes/pentagon_gloink.tscn")

func _ready() -> void:
	wave3()

func wave1():
	$WaveTitle.update_wave_num(1)
	for i in 10:
		var new_gloink = triangle.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
		
func wave2():
	$WaveTitle.update_wave_num(2)
	for i in 10:
		var new_gloink = triangle.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 3:
		var new_gloink = square.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)

func wave3():
	$WaveTitle.update_wave_num(3)
	for i in 6:
		var new_gloink = triangle.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 4:
		var new_gloink = square.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)
	
	for i in 3:
		var new_gloink = pentagon.instantiate()
		new_gloink.global_position = random_path_point()
		new_gloink.shooter_man = $"../ShooterMan"
		new_gloink.get_node("StartWait").wait_time = randf_range(1, 6)
		%Gloinks.add_child(new_gloink)


func random_path_point() -> Vector2:
	path.progress_ratio = randf()
	return path.global_position
