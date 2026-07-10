extends CharacterBody2D

@export var max_health = 100.00
@export var health = 100.00
@export var damage = 30
@export var enabled = true
const SPEED = 60.0
var attacking = false
var launched = false

var indicator_scene = preload("res://scenes/heptagon_ground_indicator.tscn")


func _ready() -> void:
	if %ShooterMan && enabled:
		$AttackStartDelay.wait_time = randf_range(0, 1)
		$StartDelay.start()
	$SimpleHealthBar.hide_bar()

func _physics_process(_delta: float) -> void:
	if %ShooterMan && enabled && !attacking:
		var direction = (%ShooterMan.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
	elif %ShooterMan && enabled && launched:
		velocity.y = -600
		velocity.x = 0
		move_and_slide()

func _on_start_delay_timeout() -> void:
	$AttackStartDelay.start()

func _on_attack_start_delay_timeout() -> void:
	attacking = true
	$AnimationPlayer.play("Dig")
	$CollisionPolygon2D.disabled = true
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# place indicator and pos near player
	if anim_name == "Dig":
		var pos = %ShooterMan.position + Vector2(randi_range(-75, 75), randi_range(-75, 75))
		var indicator = indicator_scene.instantiate()
		indicator.position = pos
		position = pos
		$"../..".add_child(indicator)
		
		$LaunchAnimPause.start() # start timer that ends when the launch animation does the launch thing



func _on_launch_anim_pause_timeout() -> void:
	$AnimationPlayer.play("RESET")
	$CollisionPolygon2D.disabled = false
	launched = true
	set_collision_layer_value(1, false) # change collision layer to 3 so that the gloiunk doesn't collide with other gloinks or projectiles
	set_collision_mask_value(1, false)
	set_collision_layer_value(3, true)
	set_collision_mask_value(3, true)
	
	damage = 60 # make damage happen

func _on_max_fly_time_timeout() -> void:
	queue_free()

func update_health(change: float):
	if !launched:
		health += change
		$SimpleHealthBar.show_bar()
		$SimpleHealthBar.update(max_health, health)
		if health <= 0:
			queue_free()
