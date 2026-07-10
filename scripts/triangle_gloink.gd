extends CharacterBody2D

@export var max_health = 50.00
@export var health = 50.00
@export var damage = 20
@export var enabled = true
const SPEED = 60.0

func _ready() -> void:
	$SimpleHealthBar.hide_bar()

func _physics_process(_delta: float) -> void:
	if %ShooterMan && enabled:
		var direction = (%ShooterMan.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

func update_health(change: float):
	health += change
	$SimpleHealthBar.show_bar()
	$SimpleHealthBar.update(max_health, health)
	if health <= 0:
		queue_free()
