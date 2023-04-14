extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
