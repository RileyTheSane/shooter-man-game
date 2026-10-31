extends CharacterBody2D

var max_health = 100.00
var health = 100.00
var damage = 30
@export var enabled = false
@export var shooter_man = null
var speed = 60.0
var attacking = false
var launched = false

var indicator_scene = preload("res://scenes/heptagon_ground_indicator.tscn")

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
	if shooter_man && enabled && !attacking:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	elif shooter_man && enabled && launched:
		velocity.y = -600
		velocity.x = 0
		move_and_slide()

func _on_attack_start_delay_timeout() -> void:
	attacking = true
	$AnimationPlayer.play("Dig")
	$CollisionPolygon2D.disabled = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# place indicator and pos near player
	if anim_name == "Dig":
		var pos = shooter_man.position + Vector2(randi_range(-75, 75), randi_range(0, 75))
		var indicator = indicator_scene.instantiate()
		indicator.position = pos
		position = pos
		$SimpleHealthBar.hide()
		$"../../Effects".add_child(indicator)
		
		$LaunchAnimPause.start() # start timer that ends when the launch animation does the launch thing

func _on_launch_anim_pause_timeout() -> void:
	$AnimationPlayer.play("RESET")
	$CollisionPolygon2D.disabled = false
	launched = true
	set_collision_layer_value(1, false) # change collision layer to 3 so that the gloiunk doesn't collide with other gloinks or projectiles
	set_collision_mask_value(1, false)
	set_collision_layer_value(3, true)
	
	if (health < max_health):
		$SimpleHealthBar.show()
	damage = 60 # make damage happen

func update_health(change: float):
	if (health > 0): # only do the sound effects and stuff if the gloink is still alive (health > 100)
		if (launched):
			health += change * 2 # heptagon takes double damage when launched
		else:
			health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
	
		if (change < 0):
			$HitSoundEffect.play()
		
		if health <= 0:
			enabled = false
			$AttackStartDelay.stop()
			set_collision_layer_value(1, false) # make noting able to collide with the hidden gloink
			set_collision_mask_value(1, false)
			$DeathSoundEffect.play()
			hide()

func _on_death_sound_effect_finished() -> void:  # on death queue free so that the sound effect still plays
	$"../..".gloinkKillPoints += 25
	queue_free()

func _on_start_wait_timeout() -> void:
	enabled = true
	$AttackStartDelay.wait_time = randf_range(3, 9)
	$AttackStartDelay.start()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
