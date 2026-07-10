extends CharacterBody2D

@export var max_health = 125.00
@export var health = 125.00
@export var damage = 30
@export var enabled = true
const SPEED = 60.0
var octagon_projectile_script = preload("res://scenes/octagon_projectile.tscn")

func _ready() -> void:
	if enabled:
		$RandomStartOffset.wait_time = randf_range(0, 1)
		$RandomStartOffset.start()
	$SimpleHealthBar.hide_bar()

func _physics_process(_delta: float) -> void:
	if %ShooterMan && enabled:
		var direction = (%ShooterMan.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()


func _on_shoot_timer_timeout() -> void:
	if %ShooterMan:
		for i in 3:
			var direction = (%ShooterMan.position - position).normalized()
			var offset = 16 - i * 8 # second number is the angle difference between bullters, first number is twice the second number
			direction = direction.rotated(deg_to_rad(offset))
			
			var gloink_proj = octagon_projectile_script.instantiate()
			
			gloink_proj.add_to_group("gloink")
			gloink_proj.look_at(%ShooterMan.position)
			gloink_proj.velocity = direction
			gloink_proj.position = direction * 20 + position # move the proj a little bit in the direction of the target so the colliion body doesn't collide with the gloink's collider
			$"../../Projectiles".add_child(gloink_proj)

func _on_start_offset_timer_timeout() -> void:
	$ShootTimer.start()

func update_health(change: float):
	health += change
	$SimpleHealthBar.show_bar()
	$SimpleHealthBar.update(max_health, health)
	if health <= 0:
		queue_free()
