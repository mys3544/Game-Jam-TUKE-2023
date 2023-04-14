extends CharacterBody2D

var direction : Vector2 = Vector2()
@export var projectile: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
func read_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		velocity.y -=1
		direction = Vector2(0, -1)
		print("UP")

	if Input.is_action_pressed("Down"):
		velocity.y +=1
		direction = Vector2(0, 1)

	if Input.is_action_pressed("Left"):
		velocity.x -=1
		direction = Vector2(-1, 0)

	if Input.is_action_pressed("Right"):
		velocity.x +=1
		direction = Vector2(1, 0)

	velocity = velocity.normalized()*400
	move_and_slide()

func shoot() -> void:
	print("BANG")
	var instance: Projectile = projectile.instantiate()
	owner.add_child(instance)
	instance.global_transform = spawn_point.global_transform
	
func _physics_process(delta):
	read_input()
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("Shoot"): shoot()	
