extends CharacterBody2D

var max_health = 75.00
var health = 75.00
var damage = 25
@export var enabled = false
@export var shooter_man = null
var speed = 60.0
var pentagon_projectile_script = preload("res://scenes/pentagon_projectile.tscn")

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


func _on_shoot_timer_timeout() -> void:
	var gloink_proj = pentagon_projectile_script.instantiate()
	if shooter_man:
		gloink_proj.add_to_group("gloink")
		gloink_proj.look_at(shooter_man.position)
		gloink_proj.position = (shooter_man.position - position).normalized() * 20 + position
		
		var difficulty = $"../..".get_difficulty()
		match difficulty:
			"easy":
				gloink_proj.velocity = (shooter_man.position - position).normalized() * .5
			"medium":
				gloink_proj.velocity = (shooter_man.position - position).normalized() * .8
			"hard":
				gloink_proj.velocity = (shooter_man.position - position).normalized()
	$"../../Projectiles".add_child(gloink_proj)


func _on_start_offset_timer_timeout() -> void:
	$ShootTimer.start()
	
func update_health(change: float):
	if (health > 0): # only do the sound effects and stuff if the gloink is still alive (health > 100)
		health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
	
		if (change < 0):
			$HitSoundEffect.play()
		
		if health <= 0:
			enabled = false
			$ShootTimer.stop()
			set_collision_layer_value(1, false) # make noting able to collide with the hidden gloink
			set_collision_mask_value(1, false)
			$DeathSoundEffect.play()
			hide()

func _on_death_sound_effect_finished() -> void:  # on death queue free so that the sound effect still plays
	queue_free()

func _on_start_wait_timeout() -> void:
	enabled = true
	$RandomStartOffset.wait_time = randf_range(0, 1)
	$RandomStartOffset.start()
	
	var difficulty = $"../..".get_difficulty()
	match difficulty:
		"easy":
			$ShootTimer.wait_time = 4
		"medium":
			$ShootTimer.wait_time = 2.25
