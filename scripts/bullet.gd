extends CharacterBody2D

@export var damage = 50
@export var enabled = true
const SPEED = 600.00

func _ready() -> void:
	velocity *= SPEED
	$AudioStreamPlayer.play()
	$"../..".bulletsUsed += 1

func _physics_process(_delta: float) -> void:
	if enabled:
		move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("gloink"):
		body.update_health(-damage)
		queue_free()
