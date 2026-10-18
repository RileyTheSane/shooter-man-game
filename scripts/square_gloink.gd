extends CharacterBody2D

var max_health = 75.00
var health = 75.00
var damage = 25
@export var enabled = false
@export var shooter_man = null
var speed = 80.0

func _ready() -> void:
	$SimpleHealthBar.hide()


func _physics_process(_delta: float) -> void:
	if shooter_man && enabled:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

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
	if (health > 0): # only do the sound effects and stuff if the gloink is still alive (health > 100)
		health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
	
		if (change < 0):
			$HitSoundEffect.play()
		
		if health <= 0:
			set_collision_layer_value(1, false) # make noting able to collide with the hidden gloink
			set_collision_mask_value(1, false)
			$DeathSoundEffect.play()
			hide()

func _on_death_sound_effect_finished() -> void: # on death queue free so that the sound effect still plays
	queue_free()

func _on_start_wait_timeout() -> void:
	enabled = true
	$RollTimer.start()
