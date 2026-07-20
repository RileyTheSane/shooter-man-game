extends CharacterBody2D

var max_health = 30.00
var health = 30.00
var damage = 70
@export var enabled = false
@export var shooter_man = null
const SPEED = 300.0
var entered_screen = false

func _ready() -> void:
	if shooter_man && enabled:
		$StartOffset.wait_time = randf_range(0, 3) # random offset wait time before attacking
		$StartOffset.start()
	$SimpleHealthBar.hide_bar()


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_max_lifetime_timeout() -> void:
	queue_free() # if it has existed for too long, kill it


func _on_start_offset_timeout() -> void:
	$MaxLifetime.start()
	look_at(shooter_man.position) # look at player
	velocity = (shooter_man.position - position).normalized() * SPEED# set velocity
	rotation_degrees += randf_range(-15, 15) # set orientation offset


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	entered_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if entered_screen:
		queue_free()

func update_health(change: float):
	health += change
	$SimpleHealthBar.show_bar()
	$SimpleHealthBar.update(max_health, health)
	if health <= 0:
		queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
