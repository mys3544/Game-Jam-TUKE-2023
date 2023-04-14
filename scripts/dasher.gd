extends CharacterBody2D

var r_speed = 100
var speed = r_speed
var to_follow = null
var direction = Vector2.ZERO
var d_direction = Vector2.ZERO
var d_speed = 300
var d_cooldown = 120
var d_timer = d_cooldown
var d_duration = 30
var dashing = false

func _physics_process(delta):
	if !dashing:
		# reset direction
		direction = Vector2.ZERO
		# if player is spotted
		if to_follow:
			# set new direction
			direction = position.direction_to(to_follow.get_global_position())
			# dash if able
			if d_timer < 0:
				speed = d_speed
				d_timer = d_duration
				dashing = true
	elif d_timer < 0:
		d_timer = d_cooldown
		speed = r_speed
		dashing = false
	# move set direction
	velocity = direction * speed
	move_and_slide()
	d_timer -= 1

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		to_follow = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		to_follow = null
