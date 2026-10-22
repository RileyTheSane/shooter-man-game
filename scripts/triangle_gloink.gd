extends CharacterBody2D

var max_health = 50.00
var health = 50.00
var damage = 20
@export var enabled = false
@export var shooter_man = null
var speed = 60.0

var start = false

func _ready() -> void:
	$SimpleHealthBar.hide()
	var difficulty = $"../..".get_difficulty()
	match difficulty:
		"easy":
			speed = 20
		"medium":
			speed = 35
		"hard":
			speed = 60

func _physics_process(_delta: float) -> void:
	if shooter_man && enabled:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func update_health(change: float):
	if (health > 0): # only do the sound effects and stuff if the gloink is still alive (health > 100)
		health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
	
		if (change < 0):
			$HitSoundEffect.play()
		
		if health <= 0:
			enabled = false
			set_collision_layer_value(1, false) # make noting able to collide with the hidden gloink
			set_collision_mask_value(1, false)
			$DeathSoundEffect.play()
			hide()

func _on_death_sound_effect_finished() -> void:  # on death queue free so that the sound effect still plays
	queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
