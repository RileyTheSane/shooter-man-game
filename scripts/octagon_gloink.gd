extends CharacterBody2D

var max_health = 125.00
var health = 125.00
var damage = 30
@export var enabled = false
@export var shooter_man = null
const SPEED = 60.0
var octagon_projectile_script = preload("res://scenes/octagon_projectile.tscn")

func _ready() -> void:
	$SimpleHealthBar.hide()

func _physics_process(_delta: float) -> void:
	if shooter_man && enabled:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()


func _on_shoot_timer_timeout() -> void:
	if shooter_man:
		for i in 3:
			var direction = (shooter_man.position - position).normalized()
			var offset = 16 - i * 8 # second number is the angle difference between bullters, first number is twice the second number
			direction = direction.rotated(deg_to_rad(offset))
			
			var gloink_proj = octagon_projectile_script.instantiate()
			
			gloink_proj.add_to_group("gloink")
			gloink_proj.look_at(shooter_man.position)
			gloink_proj.velocity = direction
			gloink_proj.position = direction * 20 + position # move the proj a little bit in the direction of the target so the colliion body doesn't collide with the gloink's collider
			$"../../Projectiles".add_child(gloink_proj)


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

func _on_death_sound_effect_finished() -> void:  # on death queue free so that the sound effect still plays
	queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
	$ShootTimer.start()
