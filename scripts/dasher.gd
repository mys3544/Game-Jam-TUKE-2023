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
	# reset direction
	direction = Vector2.ZERO
	# if player is spotted
	if to_follow:
		# not dashing and on cooldown
		if d_timer > 0 and !dashing:
			# set new direction
			direction = position.direction_to(to_follow.get_global_position()) * speed
		# finished dashing
		elif d_timer < 0 and dashing:
			dashing = false
			d_timer = d_cooldown
			speed = r_speed
		# start dashing
		else:
			speed = d_speed
			dashing = true
			d_timer = d_duration
	d_timer -= 1
	# move set direction
	velocity = direction
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		to_follow = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		to_follow = null
