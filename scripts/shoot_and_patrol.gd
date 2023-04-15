extends CharacterBody2D

var speed = 75
var cur_speed = speed
var target = null
const bullet_obj = preload("res://scenes/hostiles/enemy_bullet.tscn")
const cooldown = 120
var timer = cooldown
var m_cooldown = 60
var m_timer = m_cooldown
var backing = false

func _physics_process(delta):
	if backing:
		move_and_slide()
	# prevent bullet spam
	if timer < 0:
		# if there is target
		if target:
			shoot()
			timer = cooldown
		# wait
		else:
			timer = 0
	# move if there is no target in range
	if !target:
		move_and_slide()
		# reduce timer
		m_timer -= 1
		# change direction after a period of time
		if m_timer < 0:
			change_dir()
			m_timer = m_cooldown
	# count down
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
	# set starting position
	bullet.position = position + (position.direction_to(target.get_global_position()) * 30)
	# set direction
	bullet.look_at(target.get_global_position())

func change_dir():
	velocity = Vector2(speed, 0).rotated(randf() * 2.0 * PI)

func bounce():
	velocity = position.direction_to(target.get_global_position()) * cur_speed * -1
	backing = true
	await get_tree().create_timer(0.5).timeout
	backing = false
