extends CharacterBody2D

const Health = preload("res://scripts/health.gd")

var entity_hp = null

var speed = 100
var cur_speed = speed
var to_follow = null
var direction = Vector2.ZERO
var d_direction = Vector2.ZERO
var d_speed = 300
var d_cooldown = 120
var d_timer = d_cooldown
var d_duration = 30
var dashing = false
var dashes = 2
var backing = false

func _ready():
	entity_hp = Health.new()

func _physics_process(delta):
	if !dashing and !backing:
		# reset direction
		direction = Vector2.ZERO
		# if player is spotted
		if to_follow:
			# set new direction
			direction = position.direction_to(to_follow.get_global_position())
			# dash if able
			if d_timer < 0:
				dashes -= 1
				cur_speed = d_speed
				d_timer = d_duration
				dashing = true
	# finish dash
	elif d_timer < 0:
		# if there are no left reset cooldown and replenish dash
		if dashes < 1:
			d_timer = d_cooldown
			dashes = 2
		# reset speed and such
		cur_speed = speed
		dashing = false
	# move set direction
	velocity = direction * cur_speed
	move_and_slide()
	d_timer -= 1

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		to_follow = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		to_follow = null

func bounce():
	direction *= -1
	backing = true
	await get_tree().create_timer(0.5).timeout
	backing = false

func die():
	queue_free()
