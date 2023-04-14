extends CharacterBody2D

var speed = 100
var direction = Vector2.ZERO
var to_follow = null

func _physics_process(delta):
	# reset direction
	direction = Vector2.ZERO
	# if player is spotted
	if to_follow:
		# set new direction
		direction = position.direction_to(to_follow.position) * speed
	# move set direction
	velocity = direction
	move_and_slide()

# on enter set node to be followed and on leave stop
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		to_follow = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		to_follow = null
