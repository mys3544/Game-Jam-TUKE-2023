extends CharacterBody2D

var speed = 100
var shot_dir = Vector2.ZERO
var target = null
const bullet_obj = preload("res://scenes/enemy_bullet.tscn")
var timer = 120

func _physics_process(delta):
	if timer < 0:
		if target:
			shoot()
			timer = 120
		else:
			timer = 0
	timer -= 1

# on enter set node to be followed and on leave stop
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		target = null

func shoot():
	# instantiate object
	var bullet = bullet_obj.instantiate()
	get_parent().add_child(bullet)
	# set direction
	bullet.position = position + (position.direction_to(target.position) * 30)
	shot_dir = target.position - bullet.position
	bullet.velocity = shot_dir
