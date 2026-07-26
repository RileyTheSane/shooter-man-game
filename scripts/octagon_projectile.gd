extends CharacterBody2D

@export var health = 1
@export var damage = 15
@export var enabled = true
var bullet_velocity = 1.00
var bullet_velocity_decrease = .9985
var decay_started = false
const SPEED = 400.00

func _ready() -> void:
	velocity *= SPEED


func _physics_process(delta: float) -> void:
	if enabled:
		if !(velocity < Vector2(1, 1) && velocity > Vector2(-1, -1)):
			bullet_velocity *= bullet_velocity_decrease * ((1.00 / 60) / delta) # this is so the slow down of the bullet is effected by frame rate
			velocity *= bullet_velocity
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
