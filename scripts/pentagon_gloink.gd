extends CharacterBody2D

var max_health = 75.00
var health = 75.00
var damage = 25
@export var enabled = false
@export var shooter_man = null
const SPEED = 60.0
var pentagon_projectile_script = preload("res://scenes/pentagon_projectile.tscn")

func _ready() -> void:
	$SimpleHealthBar.hide()


func _physics_process(_delta: float) -> void:
	if shooter_man && enabled:
		var direction = (shooter_man.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()


func _on_shoot_timer_timeout() -> void:
	var gloink_proj = pentagon_projectile_script.instantiate()
	if shooter_man:
		gloink_proj.add_to_group("gloink")
		gloink_proj.look_at(shooter_man.position)
		gloink_proj.velocity = (shooter_man.position - position).normalized()
		gloink_proj.position = (shooter_man.position - position).normalized() * 20 + position
	$"../../Projectiles".add_child(gloink_proj)


func _on_start_offset_timer_timeout() -> void:
	$ShootTimer.start()
	
func update_health(change: float):
	if (health):
		health += change
		$SimpleHealthBar.show()
		$SimpleHealthBar.update(max_health, health)
		if health <= 0:
			queue_free()


func _on_start_wait_timeout() -> void:
	enabled = true
	$RandomStartOffset.wait_time = randf_range(0, 1)
	$RandomStartOffset.start()
