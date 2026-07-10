extends CharacterBody2D

@export var damage = 25
const SPEED = 600.00

func _ready() -> void:
	velocity *= SPEED

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("gloink"):
		body.update_health(-damage)
		queue_free()
