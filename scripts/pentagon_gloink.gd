extends CharacterBody2D

@export var max_health = 75.00
@export var health := 75.00
@export var damage = 25
@export var enabled = true
const SPEED = 60.0
var pentagon_projectile_script = preload("res://scenes/pentagon_projectile.tscn")

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
	var gloink_proj = pentagon_projectile_script.instantiate()
	if %ShooterMan:
		gloink_proj.add_to_group("gloink")
		gloink_proj.look_at(%ShooterMan.position)
		gloink_proj.velocity = (%ShooterMan.position - position).normalized()
		gloink_proj.position = (%ShooterMan.position - position).normalized() * 20 + position
	$"../../Projectiles".add_child(gloink_proj)


func _on_start_offset_timer_timeout() -> void:
	$ShootTimer.start()
	
func update_health(change: float):
	if (health):
		health += change
		$SimpleHealthBar.show_bar()
		$SimpleHealthBar.update(max_health, health)
		if health <= 0:
			queue_free()
