extends CharacterBody2D

@export var health = 1
@export var damage = 10
var bullet_velocity_decrease = .975
var decay_started = false
const SPEED = 300.00

func _ready() -> void:
	velocity *= SPEED

func _physics_process(delta: float) -> void:
	if !(velocity < Vector2(1, 1) && velocity > Vector2(-1, -1)):
		velocity *= bullet_velocity_decrease * ((1.00 / 60) / delta) # this is so the slow down of the bullet is effected by frame rate
	else:
		if !decay_started:
			$Decay.start()
			decay_started = true
		var percentage_left = $Decay.time_left / $Decay.wait_time
		$AnimatedSprite2D.modulate.a = percentage_left
	move_and_slide()


func _on_decay_timeout() -> void:
	queue_free()

func update_health(change: float):
	health += change
	
	if health <= 0:
		queue_free()
