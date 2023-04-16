extends CharacterBody2D

const Health = preload("res://scripts/health.gd")
var entity_hp = null

var speed = 75
var prev_speed = speed
var cur_speed = speed : get = get_cur_speed, set = set_cur_speed
var target = null
const bullet_obj = preload("res://scenes/hostiles/enemy_bullet.tscn")
const cooldown = 120
var timer = cooldown
var m_cooldown = 60
var m_timer = m_cooldown
var backing = false
var slowed = false

@onready var Dead = $Dead
@onready var animation = $AnimationPlayer

func get_cur_speed():
	return cur_speed
	
func set_cur_speed(new_cur_speed):
	cur_speed = new_cur_speed

func _ready():
	entity_hp = Health.new()
	animation.play("front_default")

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
	velocity = Vector2(cur_speed, 0).rotated(randf() * 2.0 * PI)

func bounce():
	velocity = position.direction_to(target.get_global_position()) * cur_speed * -1
	backing = true
	await get_tree().create_timer(0.5).timeout
	backing = false

func _on_area_2d_area_entered(area):
	if !slowed && area.is_in_group("projectile") && area.get_cold_pillow_check():
		slowed = true
		prev_speed = cur_speed
		set_cur_speed(cur_speed/100*10)
		velocity = velocity.normalized() * cur_speed
		await get_tree().create_timer(1.5).timeout
		set_cur_speed(prev_speed)
		slowed = false

func die():
	Dead.play()
	speed = 0
	await get_tree().create_timer(1).timeout
	GlobalVariables.set_kills(1)
	queue_free()
