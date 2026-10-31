extends CharacterBody2D

var max_health = 30.00
var health = 30.00
var damage = 70
@export var enabled = false
@export var shooter_man = null
var speed = 300.0

func _ready() -> void:
	$SimpleHealthBar.hide()
	var difficulty = $"../..".get_difficulty()
	match difficulty:
		"easy":
			speed = 140
		"medium":
			speed = 225
		"hard":
			speed = 300

func _physics_process(_delta: float) -> void:
	if enabled:
		move_and_slide()


func _on_max_lifetime_timeout() -> void:
	queue_free() # if it has existed for too long, kill it

func update_health(change: float):
	if (health > 0): # only do the sound effects and stuff if the gloink is still alive (health > 100)
		health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
	
		if (change < 0):
			$HitSoundEffect.play()
		
		if health <= 0:
			enabled = false
			set_collision_layer_value(1, false) # make nothing able to collide with the hidden gloink
			set_collision_mask_value(1, false)
			$DeathSoundEffect.play()
			hide()

func _on_death_sound_effect_finished() -> void:  # on death queue free so that the sound effect still plays
	$"../..".gloinkKillPoints += 35
	queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
	
	$MaxLifetime.start()
	look_at(shooter_man.position) # look at player
	velocity = (shooter_man.position - position).normalized() * speed# set velocity
	rotation_degrees += randf_range(-15, 15) # set orientation offset
