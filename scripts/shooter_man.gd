extends CharacterBody2D

@export var health = 40.00
@export var max_health = 40.00
const MOVE_SPEED = 160.00
@export var can_take_damage = true
var shooting = false

var can_move = true # these varaibles are here to disable any common functions for stuff like cutscenes
var can_shoot = true
var arm_can_rotate = true

var bullet_scene = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	$HealthBar.hide()
	
func _physics_process(delta: float) -> void:
	if can_move:
		var direction = Input.get_vector("playerLeft", "playerRight", "playerUp", "playerDown")
		updateAnimation(direction) # update animation based on movement direction
		position += direction * delta * MOVE_SPEED # actually move player
	
	if arm_can_rotate:
		$Arm.look_at(get_global_mouse_position())
		var angle = abs(int($Arm.rotation_degrees) % 360)
		if angle > 90 && angle < 270: # flip the arm if it's on the left side of the player
			$Arm/AnimatedSprite2D.flip_v = true
		else:
			$Arm/AnimatedSprite2D.flip_v = false
		
	if can_shoot:
		if Input.is_action_just_pressed("shoot"):
			if !shooting:
				$ShootCooldown.start()
				shooting = true
				var bullet = bullet_scene.instantiate()
				bullet.position = $Arm/Marker2D.global_position
				bullet.rotation = $Arm.rotation
				var dir_offset = randf_range(-1.5, 1.5)
				bullet.velocity = (get_global_mouse_position() - bullet.position).normalized().rotated(deg_to_rad(dir_offset)) # set the direction to send the bullet in and add offset
				%Projectiles.add_child(bullet)

# change animation based on walking direction. walking up or down takes priority over left and right
func updateAnimation(direction):
	if direction.y < 0:
		reset_offset_and_flip()
		$Body.play("walkingUp")
	elif direction.y > 0:
		reset_offset_and_flip()
		$Body.play("walkingDown")
	elif direction.x > 0:
		reset_offset_and_flip()
		$Body.play("walking")
	elif direction.x < 0:
		$Body.offset = Vector2(11, 0)
		$Body.flip_h = true
		$Body.play("walking")
	else:
		reset_offset_and_flip()
		$Body.play("idle")
		
func reset_offset_and_flip():
	$Body.offset = Vector2(0, 0)
	$Body.flip_h = false

func _on_damage_tick_timeout() -> void:
	can_take_damage = true

func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("gloink") && can_take_damage:
		$DamageTick.start()
		health -= body.damage
		can_take_damage = false
		$HealthBar.update(max_health, health)
	
	if health <= 0:
		can_move = false # stop normal functions
		can_shoot = false
		arm_can_rotate = false
		$"../WavePlayer".stop_wave() # stop all of the gloinks
		$Arm.visible = false # turn rotating arm and health bar invis
		$HealthBar.hide()
		$"../Camera2D".play_death_camera_effects() # start the camera effects eg: zoom and greyscale
		$DeathAnimTimer.start() # start the death animation sequence
		$Body.flip_h = false
		$Body.play("deadarms")
		$Body.offset = Vector2(0, 0)

func _on_shoot_cooldown_timeout() -> void:
	shooting = false
	
	
var curDeathAnim = 0
func updateDeathAnim():
	curDeathAnim += 1
	
	match curDeathAnim:
		1:
			$Body.play("deathAnimation1")
			$DeathAnimTimer.start()
			$Body.offset = Vector2(22, 0)
		2:
			$Body.play("deathAnimation2")
			$DeathAnimTimer.start()
		3:
			curDeathAnim = 0
			$"../HUD/RetryButton".show_button()
			

func _on_death_anim_timer_timeout() -> void:
	updateDeathAnim()
	

func reset():
	position = Vector2(480, 270)
	health = max_health # reset health
	can_move = true # resume normal functions
	can_shoot = true
	arm_can_rotate = true
	$Arm.visible = true
