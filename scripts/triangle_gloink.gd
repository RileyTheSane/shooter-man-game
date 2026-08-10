extends CharacterBody2D

var max_health = 50.00
var health = 50.00
var damage = 20
@export var enabled = false
@export var shooter_man = null
const SPEED = 60.0

var start = false

func _ready() -> void:
	$SimpleHealthBar.hide()

func _physics_process(_delta: float) -> void:
	if shooter_man && enabled:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

func update_health(change: float):
	health += change
	$SimpleHealthBar.show()
	$SimpleHealthBar.update(max_health, health)
	if health <= 0:
		queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
