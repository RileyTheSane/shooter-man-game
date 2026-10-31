extends CharacterBody2D

@export var health = 1
@export var damage = 10
@export var enabled = true
var bullet_velocity_decrease = .975
var decay_started = false
const SPEED = 300.00

func _ready() -> void:
	velocity *= SPEED

func _physics_process(delta: float) -> void:
	if enabled:
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
		hide()
		$DeathSoundEffect.play()
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)


func _on_death_sound_effect_finished() -> void:
	queue_free()
