extends CharacterBody2D

@export var max_health = 75.00
@export var health = 75.00
@export var enabled = true
@export var damage = 25
var speed = 80.0

func _ready() -> void:
	if enabled:
		$RandomStartOffset.wait_time = randf_range(0, 4)
		$RandomStartOffset.start()
	$SimpleHealthBar.hide_bar()


func _physics_process(_delta: float) -> void:
	if %ShooterMan && enabled:
		var direction = (%ShooterMan.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()


func _on_random_start_offset_timeout() -> void: # off set the time that the square rolls so that every square doesn't roll at once
	$RollTimer.start()

func _on_roll_timer_timeout() -> void:
	$RollStop.start() # start the roll stop timer
	speed = 250
	damage = 50
	$AnimationPlayer.play("Roll")

func _on_roll_stop_timeout() -> void: # when the roll stops, reset the rotation with RESET animation
	speed = 65
	damage = 25
	$AnimationPlayer.play("RESET")

func update_health(change: float):
	health += change
	$SimpleHealthBar.show_bar()
	$SimpleHealthBar.update(max_health, health)
	if health <= 0:
		queue_free()
