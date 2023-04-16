extends CharacterBody2D

var direction : Vector2 = Vector2()
var prev_velocity_multiplier = 0
var velocity_multiplier = 200

@export var projectile: PackedScene
@export var ProjectileCooldown : float
@export var ProjectilesInMagazine : int
var maxProjectilesInMagazine = 10

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var gunShot = $GunShot
@onready var ProjectileCooldownNode = $ProjectileCooldownNode

var cold_pillow_check = false
var warm_blanket_check = false

signal pause
signal unpause

func read_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		velocity.y -=1
		direction = Vector2(0, -1)

	if Input.is_action_pressed("Down"):
		velocity.y +=1
		direction = Vector2(0, 1)

	if Input.is_action_pressed("Left"):
		velocity.x -=1
		direction = Vector2(-1, 0)

	if Input.is_action_pressed("Right"):
		velocity.x +=1
		direction = Vector2(1, 0)

	velocity = velocity.normalized()*velocity_multiplier
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if get_tree().paused:
				unpause.emit()
			else:				
				pause.emit()

func shoot() -> void:
	#print("BANG")
	ProjectileCooldownNode.start(ProjectileCooldown)
	gunShot.play()
	var instance: Projectile = projectile.instantiate()
	owner.add_child(instance)
	instance.global_transform = spawn_point.global_transform
	instance.set_cold_pillow_check(cold_pillow_check)
	instance.set_warm_blanket_check(warm_blanket_check)
	ProjectilesInMagazine -= 1
	if ProjectilesInMagazine < 1:
		print("Reloading")
		ProjectileCooldownNode.start(3)
		ProjectilesInMagazine = maxProjectilesInMagazine

func _physics_process(delta):
	read_input()
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("Shoot") and ProjectileCooldownNode.is_stopped():
		shoot()

func _on_player_speed_boost_start():
	prev_velocity_multiplier = velocity_multiplier
	velocity_multiplier = 1000

func _on_player_speed_boost_stop():
	velocity_multiplier = prev_velocity_multiplier

func _on_player_slow_down_start():
	prev_velocity_multiplier = velocity_multiplier
	velocity_multiplier = 150

func _on_player_slow_down_stop():
	velocity_multiplier = prev_velocity_multiplier

func _on_inventory_alarm_clock_item():
	velocity_multiplier += velocity_multiplier/100*5

func _on_inventory_slippers_item():
	maxProjectilesInMagazine += 1

func _on_inventory_coffee_item():
	ProjectileCooldown -= ProjectileCooldown/100*5

func _on_inventory_cold_pillow_item():
	cold_pillow_check = true

func _on_inventory_warm_blanket_item():
	warm_blanket_check = true
